//
//  MainView.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol IMainView {
    func getTableView() -> MainTableView
    var onTouchedHandler: ((String) -> Void)? { get set }
}

final class MainView: UIView {
    
    private enum Literal {
        static var placeholder = "Enter an image url"
        static var buttonTitle = "GO"
        static var noText = ""
    }
    
    private enum Metrics {
        static var standartSpacing = CGFloat(20)
        static var searchFieldHeight = CGFloat(30)
        static var tableViewHeight = CGFloat(1.2)
        static var buttonHeight = CGFloat(30)
        static var buttonWidth = CGFloat(40)
        static var buttonLeadingSpacing = CGFloat(5)
    }
    
    private lazy var searchField: UITextField = {
        let field = UITextField()
        field.placeholder = Literal.placeholder
        field.backgroundColor = .yellow
        return field
    }()
    
    private lazy var goButton: UIButton = {
        let button = UIButton()
        button.setTitle(Literal.buttonTitle, for: .normal)
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
        self.searchField.text = Literal.noText
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
        self.searchField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.standartSpacing).isActive = true
        self.searchField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.searchField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = false
        self.searchField.heightAnchor.constraint(equalToConstant: Metrics.searchFieldHeight).isActive = true
        self.searchField.widthAnchor.constraint(equalToConstant: 50).isActive = false
        
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.tableViewHeight).isActive = true
    }
    
    func makeGoButtonConstraints() {
        self.goButton.translatesAutoresizingMaskIntoConstraints = false
        self.goButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeight).isActive = true
        self.goButton.widthAnchor.constraint(equalToConstant: Metrics.buttonWidth).isActive = true
        self.goButton.leadingAnchor.constraint(equalTo: self.searchField.trailingAnchor, constant: Metrics.buttonLeadingSpacing).isActive = true
        self.goButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.goButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.standartSpacing).isActive = true
        
    }
}

//MARK: IMainView
extension MainView: IMainView {
    
    func getTableView() -> MainTableView {
        return self.tableView
    }
    
}
