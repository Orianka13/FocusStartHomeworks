//
//  ListModell.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 08.12.2021.
//

import Foundation

final class ListModel {
    
    let marks: [Mark]
    
    init(){
        self.marks = Mark.allMarks
    }
    
    func getMarks() -> [Mark] {
        return self.marks
    }
    
}
