//
//  ListPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

protocol IListPresenter {
    func loadView(controller: ListViewController, view: ListView)
}

final class ListPresenter {
    
    private let model: IListModel
    private let router: ListRouter
    private weak var controller: ListViewController?
    private weak var view: ListView?
    
    struct Dependencies {
        let model: IListModel
        let router: ListRouter
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
}

//MARK: Private extension

private extension ListPresenter {
    
    func setHandlers() {
        
        self.view?.collectionView.onTouchedHandler = { [weak self] indexPath in
            guard let marks = self?.model.getMarks() else { return }
            let mark = marks[indexPath.row]
            let cars = mark.car
            guard let currentVC = self?.controller else { return }
            self?.router.next(cars: cars, controller: currentVC)
        }
        
        self.view?.collectionView.loadHandler = { [weak self] (cell, indexPath) in
            guard let marks = self?.model.getMarks() else { return }
            let mark = marks[indexPath.row]
            let text = mark.mark
            cell?.setMarkLabelText(text: text)
        }
    }
}

//MARK: IListPresenter
extension ListPresenter: IListPresenter {
    
    func loadView(controller: ListViewController, view: ListView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
}
