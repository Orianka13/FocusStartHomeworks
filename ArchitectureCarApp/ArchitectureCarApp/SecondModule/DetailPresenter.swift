//
//  DetailPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

final class DetailPresenter {
    
    private var model = DetailModel()
    private var router: DetailRouter
    private weak var controller: DetailViewController?
    private weak var view: DetailView?
    
    struct Dependencies {
        let model: DetailModel
        let router: DetailRouter
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
    
    func loadView(controller: DetailViewController, view: DetailView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
    func setHandlers() {
        
    }
    
}
