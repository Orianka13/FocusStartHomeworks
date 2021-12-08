//
//  ListViewController.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit


final class ListViewController: UIViewController {
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .white
    }
    
    private enum Metrics {
        static let spacing = CGFloat(16)
        static let topSpacing = CGFloat(60)
        static let bottomSpacing = CGFloat(0)
    }
    
    private let listView: ListView
    private let presenter: IListPresenter?
    
    struct Dependencies {
        let presenter: IListPresenter
    }
    
    init(dependencies: Dependencies) {
        self.listView = ListView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.listView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(listView)
        
        self.setListView()
        
        self.view.backgroundColor = Colors.mainBackgroundColor
    }
}

//MARK: Private extension
private extension ListViewController {
    
    func setListView() {
        self.listView.translatesAutoresizingMaskIntoConstraints = false
        self.listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.spacing).isActive = true
        self.listView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Metrics.topSpacing).isActive = true
        self.listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.spacing).isActive = true
        self.listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: Metrics.bottomSpacing).isActive = true
        self.listView.heightAnchor.constraint(equalToConstant: 29).isActive = false
    }
}

