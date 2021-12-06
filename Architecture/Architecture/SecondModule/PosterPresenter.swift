//
//  PosterPresenter.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import Foundation

protocol IPosterPresenter {
    
    func loadView(controller: IPosterViewController, view: IPosterView)
    
}

final class PosterPresenter {
    
    private weak var controller: IPosterViewController?
    private weak var view: IPosterView?
    private let film: IPosterModel
    
    init(film: IPosterModel) {
        self.film = film
    }
}

//MARK: Private extension

private extension PosterPresenter {
    
    func setHandlers() {
        self.view?.onTouchedHandler = { [weak self] in
            let thirdVC = ThirdViewController()
            self?.controller?.showDescriptionViewController(controller: thirdVC)
        }
    }
    
    func getData() {
        let title = film.getTitle()
        let image = film.getImage()
        
        self.controller?.setTitle(title: title)
        self.view?.setImage(image: image)
    }
}

//MARK: IPosterPresenter

extension PosterPresenter: IPosterPresenter {
    
    func loadView(controller: IPosterViewController, view: IPosterView) {
        self.controller = controller
        self.view = view
        self.setHandlers()
        self.getData()
    }
}

