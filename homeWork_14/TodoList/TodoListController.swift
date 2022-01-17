//
//  TodoListController.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 11.01.2022.
//

import Foundation
import UIKit
import Then
import SnapKit
import RealmSwift



class TodoListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = TaskMassage()
    
    let idCell = "idCell"
    
    private let realm = try! Realm() // ссылка на объект Realm
    
    
    // add task
    @objc func addMessage() {
        let alertController = UIAlertController(title: "Введите задание", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Task"
        }
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { alert in
            
        }
        
        // событие нажатия на Create
        let alertAction2 = UIAlertAction(title: "Create", style: .default) { alert in
            
            TaskMassage.name = alertController.textFields![0].text!
            let task = Task()     // создание объекта для задачь
            task.name = alertController.textFields![0].text!
            
            try! self.realm.write {
                self.realm.add(task) // сохранение объекта в realm
                let allDogs = self.realm.objects(Task.self)
            }
            self.tableView.performBatchUpdates {
                self.model.addMessage()
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            } completion: { (result) in
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            
        }
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)
        present(alertController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        
        let btnAdd = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMessage))
        navigationItem.leftBarButtonItem = btnAdd
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeAr = UIContextualAction(style: .normal, title:"" ) { (action, view, success) in
            self.tableView.performBatchUpdates ({
                self.model.removeMessage(indexPath: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                try! self.realm.write {
                    self.realm.delete(self.realm.objects(Task.self)[indexPath.row])   // delete task
                }
                success(true)
            }, completion: nil)
        }
        swipeAr.backgroundColor = #colorLiteral(red: 0.9151962399, green: 0, blue: 0, alpha: 1)
        return UISwipeActionsConfiguration(actions: [swipeAr])
    }
    
    
}


extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TodoTableViewCell
        
        let message = model.messages[indexPath.row]
        cell.nameTaskLable.text = message.name
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
}


extension TodoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
}
