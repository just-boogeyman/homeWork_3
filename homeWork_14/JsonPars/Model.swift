//
//  Model.swift
//  homeWork_14
//
//  Created by Ярослав Кочкин on 18.01.2022.
//

import Foundation


struct Lesson: Decodable{
    
    var info: Info
    var results: [Persona]
    
    
}


struct Persona: Decodable {
    var name: String
    var status: String
    var image: String
    var species: String
}



struct Info: Decodable {
    var next: String
}

