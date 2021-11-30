//
//  PosterViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

protocol IPosterViewController: AnyObject {
    
    func setTitle(title: String)
    
    func showDescriptionViewController(controller: UIViewController)
}


final class PosterViewController: UIViewController {
    
    private enum Constants {
        static let mainBackgroundColor: UIColor = .black
        static let textColor: UIColor = .white
    }
    
    private var customView: IPosterView
    private var customPresenter: IPosterPresenter?
    
    
    init(presenter: IPosterPresenter) {
        self.customView = PosterView(frame: UIScreen.main.bounds)
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
        
        setNavigationBar()
    }
}

//MARK: Private extension

private extension PosterViewController {
    
    func setNavigationBar(){
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = Constants.textColor
        }
    }
}


//MARK: IPosterViewController

extension PosterViewController: IPosterViewController {
    
    func setTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func showDescriptionViewController(controller: UIViewController){
        self.navigationController?.present(controller, animated: true, completion: nil)
    }
    
}
