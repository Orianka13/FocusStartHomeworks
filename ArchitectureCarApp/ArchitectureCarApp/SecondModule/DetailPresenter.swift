//
//  DetailPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

protocol IDetailPresenter {
    func loadView(controller: DetailViewController, view: DetailView)
}

final class DetailPresenter {
    
    private var model: IDetailModel
    private var router: DetailRouter
    private weak var controller: DetailViewController?
    private weak var view: DetailView?
    
    struct Dependencies {
        let model: IDetailModel
        let router: DetailRouter
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.router = dependencies.router
    }
}

//MARK: Private extension
private extension DetailPresenter {
    
    func setHandlers() {
        self.view?.tableView.fillCellHandler = { [weak self] (cell, indexPath) in
            let bodyType = self?.model.getBodyType()
            let text = bodyType?[indexPath.row]
            cell.updateText(text: text ?? "Some body type")
        }
        
        self.view?.tableView.onTouchedHandler = { [weak self] (indexPath) in
            let images = self?.model.getImage()
            let image = images?[indexPath.row]
            self?.view?.updateView(image: image ?? "audiSedan")
        }
        
        self.view?.onTouchedButtonHandler = { [weak self] in
            let prices = self?.model.getPrice()
            let price = prices?[self?.view?.tableView.index ?? 0]
            self?.view?.updatePrice(price: price ?? "1 234 560 $")
        }
    }
}

//MARK: IDetailPresenter
extension DetailPresenter: IDetailPresenter {
    
    func loadView(controller: DetailViewController, view: DetailView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
        
        self.view?.setContent(image: self.model.getImage().first ?? "audiSedan",
                              price: self.model.getPrice().first ?? "1 234 560 $")
    }
}
