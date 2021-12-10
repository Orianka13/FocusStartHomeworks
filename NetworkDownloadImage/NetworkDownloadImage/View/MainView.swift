//
//  MainView.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol IMainView {
    
}

final class MainView: UIView {
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        return bar
    }()
    
    private var tableView = MainTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView()
        self.setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

//MARK: Private extension
private extension MainView {
    func addView() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    func setConstraint() {
        self.makeSearchBarConstraints()
        self.makeTableViewConstraints()
    }
    
    func makeSearchBarConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor, constant: 20).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.2).isActive = true
    }
}

//MARK: IMainView
extension MainView: IMainView {
    
}
