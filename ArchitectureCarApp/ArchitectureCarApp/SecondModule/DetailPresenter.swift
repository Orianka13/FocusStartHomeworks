//
//  DetailPresenter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import Foundation

protocol IDetailPresenter {
    func loadView(controller: IDetailViewController, view: IDetailView)
}

final class DetailPresenter {
    
    private enum Literal {
        static let defaultBodyType = "Some body type"
        static let defaultImage = "audiSedan"
        static let defaultPrice = "1 234 560 $"
    }
    
    private var model: IDetailModel
    private var router: DetailRouter
    private weak var controller: IDetailViewController?
    private var view: IDetailView?
    
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
        
        let tableView = view?.getTableView()
        
        tableView?.fillCellHandler = { [weak self] (cell, indexPath) in
            let bodyType = self?.model.getBodyType()
            let text = bodyType?[indexPath.row]
            cell.updateText(text: text ?? Literal.defaultBodyType)
        }
        
        tableView?.onTouchedHandler = { [weak self] (indexPath) in
            let images = self?.model.getImage()
            let image = images?[indexPath.row]
            self?.view?.updateView(image: image ?? Literal.defaultImage)
        }
        
        self.view?.onTouchedButtonHandler = { [weak self] in
            let prices = self?.model.getPrice()
            let index = tableView?.getIndex()
            let price = prices?[index ?? 0]
            self?.view?.updatePrice(price: price ?? Literal.defaultPrice)
        }
    }
}

//MARK: IDetailPresenter
extension DetailPresenter: IDetailPresenter {
    
    func loadView(controller: IDetailViewController, view: IDetailView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
        
        self.view?.setContent(image: self.model.getImage().first ?? Literal.defaultImage,
                              price: self.model.getPrice().first ?? Literal.defaultPrice)
        
        self.controller?.setNavigationBar()
    }
}
