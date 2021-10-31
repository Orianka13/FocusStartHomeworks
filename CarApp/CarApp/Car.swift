//
//  Car.swift
//  FocusStartHomeworks
//
//  Created by Олеся Егорова on 29.10.2021.
//

import Foundation

struct Car {
    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
    
}

enum Body: String, CaseIterable {
    
    case another = "Другой"
    case sedan = "Седан"
    case universal = "Универсал"
    case cabriolet = "Кабриолет"
    case piсkup = "Пикап"
    case crossover = "Кроссовер"
    
    init?(index: Int){
        for (indexEnum, value) in Self.allCases.enumerated(){
            if indexEnum == index {
                self = value
                return
            }
        }
        return nil
    }
}

