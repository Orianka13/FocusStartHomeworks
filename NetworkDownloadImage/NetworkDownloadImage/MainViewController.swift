//
//  ViewController.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol IMainViewController: AnyObject {
    
}

class MainViewController: UIViewController {
    
    private var mainView: MainView
    private var presenter: IMainPresenter?
    
    struct Dependencies {
        let presenter: IMainPresenter
    }
    
    init(dependencies: Dependencies) {
        self.mainView = MainView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.mainView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
    }


}

//MARK: IMainViewController
extension MainViewController: IMainViewController {
    
}
