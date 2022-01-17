//
//  TodoRealm.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 11.01.2022.
//

import UIKit
import RealmSwift


class Task: Object {
    
    @objc dynamic var name = ""
    
    
}

class TodoController: UIViewController {
    
    static let shared = TodoController()
    
    private let realm = try! Realm() // ссылка на объект Realm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        TodoController.shared.test()
        

    }
    

    
    
}
