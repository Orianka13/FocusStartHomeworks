//
//  ListPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

final class ListPresenter {
    
    private var model = ListModel()
    private var router: ListRouter
    private weak var controller: ListViewController?
    private weak var view: ListView?
    
    struct Dependencies {
        let model: ListModel
        let router: ListRouter
    }

    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
    
    func loadView(controller: ListViewController, view: ListView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
    func setHandlers() {
        self.view?.collectionView.onTouchedHandler = { [weak self] in
            let nextVC = DetailAssembly.build()
            guard let currentVC = self?.controller else { return }
            self?.router.next(currentVC: currentVC, nextVC: nextVC)
                }
    }
}
