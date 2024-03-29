//
//  DetailViewController.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

class DetailViewController: UIViewController {

    private var detailView: DetailView
    private var presenter: DetailPresenter?
    
    struct Dependencies {
        let presenter: DetailPresenter
    }
    
    init(dependencies: Dependencies) {
        self.detailView = DetailView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.detailView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(detailView)
        
        setDetailView()
        
        self.view.backgroundColor = .white
    }
    
    private func setDetailView() {
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        self.detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
}
