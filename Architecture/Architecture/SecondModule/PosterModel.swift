//
//  PosterModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import Foundation
import UIKit

protocol IPosterModel {
    
    func getImage() -> String
    func getTitle() -> String
    
}

final class PosterModel {
    
    private var poster: String
    private var title: String
    
    init(film: Film) {
        self.poster = film.poster
        self.title = film.name
    }
}

//MARK: IPosterModel

extension PosterModel: IPosterModel {
    
    func getImage() -> String {
        return self.poster
    }
    
    func getTitle() -> String {
        return self.title
    }
}
