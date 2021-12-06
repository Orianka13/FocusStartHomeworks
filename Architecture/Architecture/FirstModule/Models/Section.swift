//
//  Section.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 21.11.2021.
//

import Foundation

struct Section: Hashable {
    
    private enum Constants {
        static let movies = "movies"
        static let cartoons = "cartoons"
        static let tvShows = "TVshows"
    }
    
    var id = UUID()
    var title: String
    var films: [Film]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

extension Section {
    static var allSections: [Section] = [
        Section(title: Constants.movies, films: Film.allMovies),
        Section(title: Constants.cartoons, films: Film.allCartoons),
        Section(title: Constants.tvShows, films: Film.allShows)
    ]
}
