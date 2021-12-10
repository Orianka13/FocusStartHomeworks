//
//  CellModel.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class Film {
    
    var id = UUID()
    
    let poster: String
    let name: String
    
    init(poster: String, name: String){
        self.poster = poster
        self.name = name
    }
}

//MARK: Hashable
extension Film: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    static func == (lhs: Film, rhs: Film) -> Bool {
      lhs.id == rhs.id
    }
}

extension Film {
    
    static func getAllMovies() -> [Film] {
        var filmArray = [Film]()
        FilmsDataCell.nameMovies.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }
    
    static func getAllCartoons() -> [Film] {
        var filmArray = [Film]()
        FilmsDataCell.nameCartoons.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }
    
    static func getAllShows() -> [Film] {
        var filmArray = [Film]()
        FilmsDataCell.nameShows.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }
    
    private enum FilmsDataCell {
        static let nameMovies = ["Deadpool","Scott Pilgrim vs. The World","Guardians of The Galaxy","Spider-Man: Into the Spider-Verse"]
        static let nameCartoons = ["Rick and Morty","Disenchantment","South Park","Close enough"]
        static let nameShows = ["Brooklyn nine-nine","Superstore","The Big Bang Theory","Russian Doll"]
    }
}




