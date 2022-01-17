//
//  TodoController.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 10.01.2022.
//

import UIKit
import RealmSwift


//class Dog: Object {
//    
//    @objc dynamic var name = ""
//    
//    
//}
//
//class TodoController: UIViewController {
//    
//    static let shared = TodoController()
//    
//    private let realm = try! Realm() // ссылка на объект Realm
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        TodoController.shared.test()
//        
//
//    }
//    
//    func test() {
//        let dog = Dog()     // создали объект
//        dog.name = "Marta"
//        
//        try! realm.write {
//            realm.add(dog) // сохранение объекта в realm
//        }
//        
//        let allDogs = realm.objects(Dog.self) // получаем всех собак которые есть в realm
//        for dog in allDogs {
//            print(dog.name)
//        }
//        
//        
//    }
//    
//    
//}
