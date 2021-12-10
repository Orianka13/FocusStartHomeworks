//
//  MainPresenter.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import Foundation

protocol IMainPresenter {
    
    func loadView(controller: IMainViewController, view: IMainView)
    
}

final class MainPresenter {
    
    private var model: IMainModel
    private var network: INetworkService
    private weak var controller: IMainViewController?
    private var view: IMainView?
    
    struct Dependencies {
        let model: IMainModel
        let network: INetworkService
    }
    
    init(dependencies: Dependencies) {
        self.model = dependencies.model
        self.network = dependencies.network
    }
}

//MARK: Private extension
private extension MainPresenter {
    func setHandlers() {
        
    }
}

//MARK: IMainPresenter

extension MainPresenter: IMainPresenter {
    
    func loadView(controller: IMainViewController, view: IMainView) {
        self.controller = controller
        self.view = view
        
        self.setHandlers()
        
    }
}
