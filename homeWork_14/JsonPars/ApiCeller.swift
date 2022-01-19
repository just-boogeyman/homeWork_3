//
//  ApiCeller.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 18.01.2022.
//

import Foundation
import UIKit
import RealmSwift


class APICaller {
        
    lazy var cachedDataSourse: NSCache<AnyObject, UIImage> = {
        let cache = NSCache <AnyObject, UIImage>()
        return cache
    }()
    
    

    
    func fetchData(urlString: String, completion: @escaping (Result<Lesson, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }// создаем url структуры экземпляра

        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            do {
                let lessons = try JSONDecoder().decode(Lesson.self, from: data)
                    completion(.success(lessons))
            }catch{
                
                print(error)
                
            }
            

        }.resume()
    }
    
    func obtainImage(urlImage: String, completion: @escaping ((UIImage?) -> Void)) {

        let url = URL(string: urlImage)

        URLSession.shared.dataTask(with: url!) { data, responce, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            else {

                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }.resume()

    }
    
    // обновление кэша
    func upDateCache(lesson: [Persona]) {
        
        for index in 0...lesson.count-1 {
            obtainImage(urlImage: (lesson[index].image)) { [weak self] (image) in
                self?.cachedDataSourse.setObject(image!, forKey: index as AnyObject)
            }
        }
    }
    
    
}
