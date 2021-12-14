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
    }
    
    func loadData(url: String) {
        self.network.loadData(url: url) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let model = MainModel(imageData: data)
                    
                    self?.tableView?.appendData(data: model)
                    
                }
            case .failure(let error):
                print("[NETWORK] error is: \(error)")
                DispatchQueue.main.async {
                    print("Загрузка закончена с ошибкой \(error.localizedDescription)")
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
