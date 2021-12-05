//
//  Data.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

struct Car {
    let image: String
    let body: String
    var price: String
}

struct Mark {
    let mark: String
    let car: [Car]
}

//private enum carData {
//    static let carMarks = ["BMW", "Audi", "Ford", "Honda"]
//
//    static let bmwImages = ["bmwSedan","bmwFurgon","bmwUniversal"]
//    static let audiImages = ["audiSedan","audiFurgon","audiUniversal"]
//    static let fordImages = ["fordSedan","fordFurgon","fordUniversal"]
//    static let hondaImages = ["hondaSedan","hondaFurgon","hondaUniversal"]
//
//    static let body = ["Седан", "Фургон", "Универсал"]
//
//    static let bmwPrice = ["2 345 678", "1 987 654", "3 898 765"]
//    static let audiPrice = ["1 678 456", "2 564 175", "5 876 345"]
//    static let fordPrice = ["3 000 000", "2 668 000", "4 678 399"]
//    static let hondaPrice = ["2 876 000", "5 765 098", "6 789 000"]
//}

extension Mark {
    
    static var allMarks: [Mark] = [Mark.bmwMark, Mark.audiMark, Mark.fordMark, Mark.hondaMark]
    
    static let bmwMark: Mark = Mark(mark: "BMW", car: [
        Car(image: "bmwSedan", body: "Седан", price: "2 345 678"),
        Car(image: "bmwFurgon", body: "Фургон", price: "1 987 654"),
        Car(image: "bmwUniversal", body: "Универсал", price: "3 898 765")])
    
    static let audiMark: Mark = Mark (mark: "Audi", car: [
        Car(image: "audiSedan", body: "Седан", price: "1 678 456"),
        Car(image: "audiFurgon", body: "Фургон", price: "2 564 175"),
        Car(image: "audiUniversal", body: "Универсал", price: "5 876 345")])
    
    static let fordMark: Mark = Mark (mark: "Audi", car: [
        Car(image: "fordSedan", body: "Седан", price: "3 000 000"),
        Car(image: "fordFurgon", body: "Фургон", price: "2 668 000"),
        Car(image: "fordUniversal", body: "Универсал", price: "4 678 399")])
    
    static let hondaMark: Mark = Mark (mark: "Audi", car: [
        Car(image: "hondaSedan", body: "Седан", price: "2 876 000"),
        Car(image: "hondaFurgon", body: "Фургон", price: "5 765 098"),
        Car(image: "hondaUniversal", body: "Универсал", price: "6 789 000")])
    
}
