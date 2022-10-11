//
//  ListModel.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 08.12.2021.
//

import Foundation

protocol IListModel {
    func getMarks() -> [Mark]
}

final class ListModel {
    
    private let marks: [Mark]
    
    init(){
        self.marks = Mark.allMarks
    }
}

// MARK: IListModel
extension ListModel: IListModel {
    
    func getMarks() -> [Mark] {
        return self.marks
    }
    
}
