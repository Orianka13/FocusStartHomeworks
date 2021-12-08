//
//  PosterModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import Foundation
import UIKit

protocol IPosterModel {
    func getData() -> Poster
}

final class PosterModel {
    
    private var poster: String
    private var title: String
    
    init(film: Film) {
        self.poster = film.poster
        self.title = film.name
    }
}

struct Poster {
    let image: String
    let title: String
}

//MARK: IPosterModel

extension PosterModel: IPosterModel {
    
    func getData() -> Poster {
        Poster.init(image: self.poster, title: self.title)
    }
}
