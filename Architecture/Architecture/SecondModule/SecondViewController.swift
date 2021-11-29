//
//  SecondViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class SecondViewController: UIViewController {
    
    private enum Constants {
        static let mainBackgroundColor: UIColor = .black
        static let textColor: UIColor = .white
    }
    
    private var customView: CustomView
    private var customPresenter: CustomPresenter?
    
    
    init(presenter: CustomPresenter) {
        self.customView = CustomView(frame: UIScreen.main.bounds)
        self.customPresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.customPresenter?.loadView(controller: self, view: self.customView)
        self.customPresenter?.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(customView)
        
        view.backgroundColor = Constants.mainBackgroundColor
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = Constants.textColor
        }
    }
    
    func setTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func showDescriptionViewController(controller: UIViewController){
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
}
