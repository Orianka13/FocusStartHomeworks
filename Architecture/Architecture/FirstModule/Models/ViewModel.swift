//
//  ViewFilmModel.swift
//  Architecture
//
//  Created by Олеся Егорова on 28.11.2021.
//

import Foundation

struct ViewFilm {
    
    let poster: String
    let name: String
    
}

struct ViewSection {
    
    let title: String
    let films: [ViewFilm]
    
}
