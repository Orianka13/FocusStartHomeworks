//
//  Section.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 21.11.2021.
//

import Foundation

class Section: Hashable {
  var id = UUID()
  var title: String
  var films: [Film]
  
  init(title: String, films: [Film]) {
    self.title = title
    self.films = films
  }
  
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
