//
//  Section.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 21.11.2021.
//

import Foundation

struct Section: Hashable {
  var id = UUID()
  var title: String
  var films: [Film]
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
  static func == (lhs: Section, rhs: Section) -> Bool {
    lhs.id == rhs.id
  }
}

extension Section {
    static var allSections: [Section] = [
        Section(title: "movies", films: Film.allMovies),
        Section(title: "cartoons", films: Film.allCartoons),
        Section(title: "TVshows", films: Film.allShows)
    ]
}
