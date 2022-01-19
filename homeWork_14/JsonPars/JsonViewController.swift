//
//  JsonViewController.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 18.01.2022.
//

import UIKit
import RealmSwift

class JsonViewController: UIViewController {
    
    let realm = try! Realm()
    lazy var categories: Results<Category> = { self.realm.objects(Category.self) }()
    
    private let apiCaller = APICaller()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var totalArrey = [Persona]()
    var lessons: Lesson? = nil
    var arreyCount: Int = 0
    let urlString = "https://rickandmortyapi.com/api/character"
    var nextStr: String = ""
    
    
    func populateDefaultCategories() {
        print("+++++")
//        if categories.count == 0 { // 1

         try! realm.write() { // 2

//          let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ] // 3

             for i in 0...totalArrey.count { // 4
                let newCategory = Category()
                newCategory.name = totalArrey[i].name
                self.realm.add(newCategory)
          }
        }
        categories = realm.objects(Category.self) // 5
        print(categories)
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
//        populateDefaultCategories()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        apiCaller.fetchData(urlString: urlString, completion: { [weak self] result in
            switch result {
            case .success(let lesson):
                self?.lessons = lesson
                self?.nextStr = lesson.info.next
                for value in lesson.results {
                    self?.totalArrey.append(value)
                }
                self?.populateDefaultCategories()
                self?.arreyCount = self?.totalArrey.count ?? 0
                self?.apiCaller.upDateCache(lesson: self!.totalArrey)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        })
    }
}


extension JsonViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.row == self.arreyCount-1 {
            apiCaller.fetchData(urlString: nextStr, completion: { [weak self] result in
                switch result {
                case .success(let lesson):
                    self?.lessons = lesson
                    self?.nextStr = lesson.info.next
                    for value in lesson.results {
                        self?.totalArrey.append(value)
                    }
                    self?.arreyCount = self?.totalArrey.count ?? 0
                    self?.apiCaller.upDateCache(lesson: self!.totalArrey)
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            })
        }
        cell.textLabel?.text = categories[indexPath.row].name
        
//        cell.textLabel?.text = totalArrey[indexPath.row].name
//        cell.imageView?.image = self.apiCaller.cachedDataSourse.object(forKey: indexPath.row as AnyObject)
        
        

        
        
        return cell
    }
}
