//
//  CompanyTableView.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import UIKit

protocol ICompanyTableView {
    
    var setCompanyNameHandler: ((CompanyModel) -> Data)? { get set }
    var didSelectRowAtHandler: (() -> Void)? { get set }
    var deleteItemHandler: ((IndexPath) -> Void)? { get set }
    var numberOfRowsInSectionHandler: (() -> Int)? { get set }
    var cellForRowAtHandler: ((IndexPath) -> String)? { get set }
    func reloadTableView()
    func getTableView() -> UITableView
}

final class CompanyTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        
    }
    
    private var tableView: UITableView = UITableView()
  
    
    var setCompanyNameHandler: ((CompanyModel) -> Data)?
    var didSelectRowAtHandler: (() -> Void)?
    var deleteItemHandler: ((IndexPath) -> Void)?
    var numberOfRowsInSectionHandler: (() -> Int)?
    var cellForRowAtHandler: ((IndexPath) -> String)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        
        self.addView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: Private extension
private extension CompanyTableView {
    
    func addView() {
        self.addSubview(tableView)
    }
    
    func setConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.zeroSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Metrics.zeroSpacing).isActive = true
    }
}

//MARK: UITableViewDataSource
extension CompanyTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = numberOfRowsInSectionHandler?()
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        let name = self.cellForRowAtHandler?(indexPath)
        cell.textLabel?.text = name
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteItemHandler?(indexPath)
       
        }
    }
}

extension CompanyTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowAtHandler?()
    }
}


//MARK: ICompanyTableView
extension CompanyTableView: ICompanyTableView {
    
    func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func getTableView() -> UITableView {
        return self.tableView
    }
}
