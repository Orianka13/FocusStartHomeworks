//
//  MainView.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol IMainView {
    func getTableView() -> MainTableView
    func setImage()
    var onTouchedHandler: ((String) -> Void)? { get set }
}

final class MainView: UIView {
    
    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter an image url"
        field.backgroundColor = .yellow
        return field
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle("GO", for: .normal)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        button.backgroundColor = .red
        return button
    }()
    
    private var tableView = MainTableView()
    
    var onTouchedHandler: ((String) -> Void)?
    
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
    @objc func loadImage(){
        guard let url = self.searchField.text else { return  }
        self.onTouchedHandler?(url)
    }
    
    func addView() {
        self.addSubview(searchField)
        self.addSubview(tableView)
        self.addSubview(goButton)
    }
    func setConstraint() {
        self.makeSearchFieldConstraints()
        self.makeTableViewConstraints()
        self.makeGoButtonConstraints()
    }
    
    func makeSearchFieldConstraints() {
        self.searchField.translatesAutoresizingMaskIntoConstraints = false
        self.searchField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.searchField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.searchField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = false
        self.searchField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.searchField.widthAnchor.constraint(equalToConstant: 50).isActive = false
        
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 20).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / 1.2).isActive = true
    }
    
    func makeGoButtonConstraints() {
        self.goButton.translatesAutoresizingMaskIntoConstraints = false
        self.goButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.goButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.goButton.leadingAnchor.constraint(equalTo: self.searchField.trailingAnchor, constant: 5).isActive = true
        self.goButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.goButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
    }
}

//MARK: IMainView
extension MainView: IMainView {
    
    func getTableView() -> MainTableView {
        return self.tableView
    }
    

    func setImage(){
        
    }
}
