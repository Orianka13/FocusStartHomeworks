//
//  DetailModel.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

protocol IDetailModel {
    
    func getImage() -> [String]
    func getPrice() -> [String]
    func getBodyType() -> [String]
}

final class DetailModel {
    
    private var allBodies: [String] = []
    private var allImages: [String] = []
    private var allPrices: [String] = []
    
    init(cars: [Car]) {
        self.allBodies = self.fillBody(cars: cars)
        self.allImages = self.fillImage(cars: cars)
        self.allPrices = self.fillPrice(cars: cars)
    }
}

//MARK: Private extension

private extension DetailModel {
    
    func fillBody(cars: [Car]) -> [String]{
        var body: [String] = []
        for car in cars {
            body.append(car.body)
        }
        return body
    }
    
    func fillImage(cars: [Car]) -> [String]{
        var image: [String] = []
        for car in cars {
            image.append(car.image)
        }
        return image
    }
    
    func fillPrice(cars: [Car]) -> [String]{
        var price: [String] = []
        for car in cars {
            price.append(car.price)
        }
        return price
    }
}

//MARK: IDetailModel

extension DetailModel: IDetailModel {
    
    func getImage() -> [String] {
        return self.allImages
    }
    
    func getPrice() -> [String] {
        return self.allPrices
    }
    
    func getBodyType() -> [String] {
        return self.allBodies
    }
}


