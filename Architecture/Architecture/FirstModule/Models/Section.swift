//
//  Section.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 21.11.2021.
//

import Foundation

protocol ISection {
    
    func getTitle() -> String
    func getFilms() -> [Film]
    
}

final class Section {

    var id = UUID()
    
    private var title: String
    private var films: [Film]
    
    init(title: String, films: [Film]){
        self.title = title
        self.films = films
        
    }
}

//MARK: ISection
extension Section {
    
    func getTitle() -> String {
        return self.title
    }
    func getFilms() -> [Film] {
        return self.films
    }
}

//MARK: Hashable
extension Section: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

extension Section {
    
    static func allSections() -> [Section] {
        
        let sections = [
            Section(title: SectionTitle.movies, films: Film.getAllMovies()),
            Section(title: SectionTitle.cartoons, films: Film.getAllCartoons()),
            Section(title: SectionTitle.tvShows, films: Film.getAllShows())
        ]
        return sections
    }
    
    private enum SectionTitle {
        static let movies = "movies"
        static let cartoons = "cartoons"
        static let tvShows = "TVshows"
    }
}
