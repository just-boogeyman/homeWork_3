//
//  TaskMassage.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 11.01.2022.
//

import Foundation




struct Messange {
    var name: String
}



class TaskMassage {
    var messages = [Messange]()
    
    static var name = ""

    
    
    func addMessage() {
        var message = Messange(name: TaskMassage.name)
        messages.insert(message, at: 0)
    }
    
    func removeMessage(indexPath: IndexPath) {
        messages.remove(at: indexPath.row)
    }
    
}
