//
//  Presenter.swift
//  Architecture
//
//  Created by Олеся Егорова on 26.11.2021.
//

import Foundation

final class CustomPresenter {
    
    private weak var controller: SecondViewController?
    private weak var view: CustomView?
    var film: FilmModel
    
    init(film: FilmModel) {
        self.film = film
    }
    
    func loadView(controller: SecondViewController, view: CustomView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
    }
    
    func setHandlers() {
        self.view?.onTouchedHandler = { [weak self] in
            
            let thirdVC = ThirdViewController()
            let thirdVM = ThirdViewModel()
            for (key, value) in DescriptionData.filmDescription {
                if key == self?.controller?.navigationItem.title {
                    thirdVM.updateData(text: value)
                }
            }
            self?.controller?.showDescriptionViewController(controller: thirdVC)
        }
    }
    
    func getData() {
        let title = film.getTitle()
        self.controller?.setTitle(title: title)
        
        let image = film.getImage()
        self.view?.setImage(image: image)
    }
}


