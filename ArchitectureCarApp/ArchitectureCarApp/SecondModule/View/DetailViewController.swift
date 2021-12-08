//
//  DetailViewController.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private enum Literal {
        static let backButtonTitle = "Back"
    }
    
    private enum Colors {
        static let mainBackgroundColor: UIColor = .white
    }
    
    private enum Metrics {
        static let leadingViewSpacing = CGFloat(15)
        static let topViewSpacing = CGFloat(90)
        static let trailingViewSpacing = CGFloat(15)
        static let zeroCpasing = CGFloat(0)
    }

    private var detailView: DetailView
    private var presenter: IDetailPresenter?
    
    struct Dependencies {
        let presenter: IDetailPresenter
    }
    
    init(dependencies: Dependencies) {
        self.detailView = DetailView(frame: UIScreen.main.bounds)
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        super.loadView()
        self.presenter?.loadView(controller: self, view: self.detailView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(detailView)
        
        self.setDetailView()
        
        self.view.backgroundColor = Colors.mainBackgroundColor
        
        self.setNavigationBar()
        
    }
    
    private func setDetailView() {
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.leadingViewSpacing).isActive = true
        self.detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Metrics.topViewSpacing).isActive = true
        self.detailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.trailingViewSpacing).isActive = true
        self.detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: Metrics.zeroCpasing).isActive = true
    }
    
    private func setNavigationBar(){
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: Literal.backButtonTitle, style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .systemGreen
        }
    }
}
