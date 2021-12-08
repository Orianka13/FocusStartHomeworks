//
//  ListViewController.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit


final class ListViewController: UIViewController {
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.listView)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(listView)
        
        self.setListView()
        
        self.view.backgroundColor = .white
    }
}

//MARK: Private extension
private extension ListViewController {
    
    func setListView() {
        self.listView.translatesAutoresizingMaskIntoConstraints = false
        self.listView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.listView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        self.listView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.listView.heightAnchor.constraint(equalToConstant: 29).isActive = false
    }
}

