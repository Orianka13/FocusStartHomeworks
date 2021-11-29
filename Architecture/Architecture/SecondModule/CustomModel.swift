//
//  FilmModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import Foundation
import UIKit

final class FilmModel {
    
    var poster: String
    var title: String
    
    init(film: Film) {
        self.poster = film.poster
        self.title = film.name
    }

    func getImage() -> String {
        return self.poster
    }
    
    func getTitle() -> String {
        return self.title
    }
}
