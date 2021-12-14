//
//  DetailRouter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import Foundation

final class DetailRouter {
    
    private var controller: DetailViewController?

    func setRootVC(controller: DetailViewController) {
        self.controller = controller
    }
}
