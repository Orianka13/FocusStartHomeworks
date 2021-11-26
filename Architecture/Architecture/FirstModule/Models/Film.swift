//
//  CellModel.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

struct Film: Hashable {
    
    var id = UUID()
    
    let poster: String
    let name: String
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    static func == (lhs: Film, rhs: Film) -> Bool {
      lhs.id == rhs.id
    }
}

extension Film {
    
    static var allMovies: [Film] = {
        var filmArray = [Film]()
        FilmsDataCell.nameMovies.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }()
    
    static var allCartoons: [Film] = {
        var filmArray = [Film]()
        FilmsDataCell.nameCartoons.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }()
    
    static var allShows: [Film] = {
        var filmArray = [Film]()
        FilmsDataCell.nameShows.forEach { film in
            filmArray.append(Film(poster: film, name: film))
        }
        return filmArray
    }()
    
}

private enum FilmsDataCell {
    static let nameMovies = ["Deadpool","Scott Pilgrim vs. The World","Guardians of The Galaxy","Spider-Man: Into the Spider-Verse"]
    static let nameCartoons = ["Rick and Morty","Disenchantment","South Park","Close enough"]
    static let nameShows = ["Brooklyn nine-nine","Superstore","The Big Bang Theory","Russian Doll"]
}


enum DescriptionData {
    static let filmDescription = ["Deadpool": "Deadpool is a 2016 American superhero film based on the Marvel Comics character of the same name. Distributed by 20th Century Fox, it is a spin-off in the X-Men film series and the eighth installment overall .",
                                  "Scott Pilgrim vs. The World": "Scott Pilgrim vs. the World is a 2010 romantic action comedy film co-written, produced, and directed by Edgar Wright, based on the graphic novel series Scott Pilgrim by Bryan Lee O'Malley.",
                                  "Guardians of The Galaxy": "Guardians of the Galaxy is a 2014 American superhero film based on the Marvel Comics superhero team of the same name.",
                                  "Spider-Man: Into the Spider-Verse": "Spider-Man: Into the Spider-Verse is a 2018 American computer-animated superhero film featuring the Marvel Comics character Miles Morales, produced by Columbia Pictures and Sony Pictures Animation in association with Marvel.",
                                  "Rick and Morty": "Rick and Morty is an American adult animated science fiction sitcom created by Justin Roiland and Dan Harmon for Cartoon Network's nighttime programming block, Adult Swim. ",
                                  "Disenchantment": "Disenchantment is an American adult satirical fantasy animated sitcom created by Matt Groening for Netflix. The series is Groening's first production to appear exclusively on a streaming service; he previously created The Simpsons and Futurama for the Fox Broadcasting Company.",
                                  "South Park": "South Park is an American adult animated sitcom created by Trey Parker and Matt Stone and developed by Brian Graden for Comedy Central. ",
                                  "Close enough": "Close Enough is an American adult animated sitcom created by J. G. Quintel. Originally intended to air on TBS in 2017, the project faced various delays and setbacks before eventually premiering on HBO Max on July 9, 2020. ",
                                  "Brooklyn nine-nine": "Brooklyn Nine-Nine is an American police procedural comedy television series that aired on Fox, later airing on NBC from September 17, 2013, to September 16, 2021, after eight seasons and 153 episodes. ",
                                  "Superstore": "Superstore is an American sitcom television series that ran on NBC from November 30, 2015, until March 25, 2021. The series was created by Justin Spitzer, who served as an executive producer for four seasons.",
                                  "The Big Bang Theory": "The Big Bang Theory is an American television sitcom created by Chuck Lorre and Bill Prady, both of whom served as executive producers on the series, along with Steven Molaro. ",
                                  "Russian Doll": "Russian Doll is an American comedy-drama streaming television series, created by Natasha Lyonne, Leslye Headland, and Amy Poehler, that premiered on February 1, 2019, on Netflix. "]
}




