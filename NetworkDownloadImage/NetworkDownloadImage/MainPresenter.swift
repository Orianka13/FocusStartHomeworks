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
    
    private enum Literal {
        static var errorTitle = "Error"
        static var errorMessage = "Ошибка загрузки изображения: "
        static var fileLocationMessage = "Данные загружены"
    }
    
    private var network: INetworkService
    private weak var controller: IMainViewController?
    private var view: IMainView?
    
    private var tableView: MainTableView?
    
    struct Dependencies {
        let network: INetworkService
    }
    
    init(dependencies: Dependencies) {
        self.network = dependencies.network
    }
}

//MARK: Private extension
private extension MainPresenter {
    func setHandlers() {
        
        self.view?.onTouchedHandler = { [weak self] url in
            self?.loadData(url: url)
        }
        
        self.tableView?.setImageHandler = { item in
            return item.getImageData()
        }
    }
    
    func loadData(url: String) {
        self.network.loadData(url: url)
        
        self.network.fileLocation = { [weak self] urlPass in
            self?.controller?.showAlert(title: Literal.fileLocationMessage, message: urlPass)
        }
        
        self.network.getData = { [weak self] data in
            DispatchQueue.main.async {
                let model = MainModel(imageData: data)
                self?.tableView?.appendData(data: model)
            }
        }
        
        self.network.getError = { [weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.controller?.showAlert(title: Literal.errorTitle, message: Literal.errorMessage + error.localizedDescription)
                }
            }
        }
    }
}

//MARK: IMainPresenter

extension MainPresenter: IMainPresenter {
    
    func loadView(controller: IMainViewController, view: IMainView) {
        self.controller = controller
        self.view = view
        
        self.tableView = view.getTableView()
        self.setHandlers()
    }
}
