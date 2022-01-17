//
//  FullName.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 09.01.2022.
//

import Foundation


class FullName{
    static let shared = FullName()
    
    
    private let kUserNameKey = "FullName.kUserNameKey"
    private let kUserSurNameKey = "FullName.kUserSurNameKey"

    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    
    var userSurName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserSurNameKey) }
    }
    
    
    
}
