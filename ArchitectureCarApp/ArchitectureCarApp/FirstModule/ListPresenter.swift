//
//  ListPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

final class ListPresenter {
    
    private var model: [Mark]
    private var router: ListRouter
    private weak var controller: ListViewController?
    private weak var view: ListView?
    
    struct Dependencies {
        let model = Mark.allMarks
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
        self.view?.collectionView.onTouchedHandler = { [weak self] indexPath in
            let mark = self?.model[indexPath.row]
            let cars = mark?.car
            
            let nextVC = DetailAssembly.build(cars: cars ?? [Car(image: "audiSedan", body: "Седан", price: "2 456 760 $")])
            guard let currentVC = self?.controller else { return }
            self?.router.next(currentVC: currentVC, nextVC: nextVC)
                }
        
        self.view?.collectionView.loadHandler = { [weak self] (cell, indexPath) in
                let text = self?.model[indexPath.row].mark
            cell?.setMarkLabelText(text: text ?? "Some mark")
        }
    }
}
