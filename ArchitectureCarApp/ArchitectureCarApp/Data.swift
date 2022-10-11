//
//  CellModel.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

struct Car {
    let image: String
    let body: String
    let price: String
}

struct Mark {
    let mark: String
    let car: [Car]
}

extension Mark {
    
    static let allMarks: [Mark] = [Mark.bmwMark, Mark.audiMark, Mark.fordMark, Mark.hondaMark, Mark.mercedesMark]
    
    static let bmwMark: Mark = Mark(mark: "BMW", car: [
        Car(image: "bmwSedan", body: "Седан", price: "2 345 678 $"),
        Car(image: "bmwFurgon", body: "Фургон", price: "1 987 654 $"),
        Car(image: "bmwUniversal", body: "Универсал", price: "3 898 765 $"),
        Car(image: "bmwH", body: "Хэтчбек", price: "3 898 000 $")])
    
    static let audiMark: Mark = Mark (mark: "Audi", car: [
        Car(image: "audiSedan", body: "Седан", price: "1 678 456 $"),
        Car(image: "audiFurgon", body: "Фургон", price: "2 564 175 $"),
        Car(image: "audiUniversal", body: "Универсал", price: "5 876 345 $"),
        Car(image: "audiH", body: "Хэтчбек", price: "2 898 000 $")])
    
    static let fordMark: Mark = Mark (mark: "Ford", car: [
        Car(image: "fordSedan", body: "Седан", price: "3 000 000 $"),
        Car(image: "fordFurgon", body: "Фургон", price: "2 668 000 $"),
        Car(image: "fordUniversal", body: "Универсал", price: "4 678 399 $"),
        Car(image: "fordH", body: "Хэтчбек", price: "1 898 000 $")])
    
    static let hondaMark: Mark = Mark (mark: "Honda", car: [
        Car(image: "hondaSedan", body: "Седан", price: "2 876 000 $"),
        Car(image: "hondaFurgon", body: "Фургон", price: "5 765 098 $"),
        Car(image: "hondaUniversal", body: "Универсал", price: "6 789 000 $"),
        Car(image: "hondaH", body: "Хэтчбек", price: "4 898 000 $")])
    
    static let mercedesMark: Mark = Mark (mark: "Mercedes", car: [
        Car(image: "mercedesSedan", body: "Седан", price: "2 000 000 $"),
        Car(image: "mercedesFurgon", body: "Фургон", price: "5 000 098 $"),
        Car(image: "mercedesUniversal", body: "Универсал", price: "6 000 000 $"),
        Car(image: "mercedesH", body: "Хэтчбек", price: "4 000 000 $")])
}




