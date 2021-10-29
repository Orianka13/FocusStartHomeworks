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

enum Body: String {
    
    case sedan = "Седан"
    case universal = "Универсальный"
    case cabriolet = "Кабриолет"
    case piсkup = "Пикап"
    case crossover = "Кроссовер"
    case another = "Другой"
    
}

