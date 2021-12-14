//
//  MainModel.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import Foundation

protocol IMainModel {
    func getImageData() -> Data
}

final class MainModel {
    private let imageData: Data
    
    init(imageData: Data) {
        self.imageData = imageData
    }
}

//MARK: IMainModel
extension MainModel: IMainModel {
    func getImageData() -> Data {
        return self.imageData
    }
}
