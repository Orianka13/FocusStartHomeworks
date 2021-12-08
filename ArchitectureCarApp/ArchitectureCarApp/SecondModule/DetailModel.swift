//
//  DetailModel.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

final class DetailModel {
    
//    private var image: String?
//    private var price: String?
//    
    private var allBodies: [String] = []
    private var allImages: [String] = []
    private var allPrices: [String] = []
    
    init(cars: [Car]) {
        
//        self.image = cars.first?.image
//        self.price = cars.first?.price
//
        self.allBodies = self.fillBody(cars: cars)
        self.allImages = self.fillImage(cars: cars)
        self.allPrices = self.fillPrice(cars: cars)
    }
    
    func getImage() -> [String] {
        return self.allImages
    }
    
    func getPrice() -> [String] {
        return self.allPrices
    }
    
    func getBodyType() -> [String] {
        return self.allBodies
    }
    
    private func fillBody(cars: [Car]) -> [String]{
        var body: [String] = []
        for car in cars {
            body.append(car.body)
        }
        return body
    }
    
    private func fillImage(cars: [Car]) -> [String]{
        var image: [String] = []
        for car in cars {
            image.append(car.image)
        }
        return image
    }
    
    private func fillPrice(cars: [Car]) -> [String]{
        var price: [String] = []
        for car in cars {
            price.append(car.price)
        }
        return price
    }
}
