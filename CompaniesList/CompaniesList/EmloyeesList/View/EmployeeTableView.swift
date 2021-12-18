//
//  EmployeeTableView.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit

protocol IEmployeeTableView {
    
    func reloadTableView()
    
    func getTableView() -> UITableView
    
    var numberOfRowsInSectionHandler: (() -> Int)? { get set }
    var didSelectRowAtHandler: ((IndexPath) -> Void)? { get set }
    var cellForRowAtHandler: ((IndexPath) -> String)? { get set }
    
}

final class EmployeeTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        
    }
    
    private var tableView: UITableView = UITableView()
  
    var numberOfRowsInSectionHandler: (() -> Int)?
    var didSelectRowAtHandler: ((IndexPath) -> Void)?
    var cellForRowAtHandler: ((IndexPath) -> String)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        
        self.tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        
        self.addView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: Private extension
private extension EmployeeTableView {
    
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
extension EmployeeTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = numberOfRowsInSectionHandler?()
        return count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseIdentifier, for: indexPath) as! EmployeeTableViewCell
        let name = self.cellForRowAtHandler?(indexPath)
        cell.textLabel?.text = name
        cell.selectionStyle = .none
        
        return cell
    }
}

extension EmployeeTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRowAtHandler?(indexPath)
    }
}


//MARK: ICompanyTableView
extension EmployeeTableView: IEmployeeTableView {
    
    func reloadTableView(){
        self.tableView.reloadData()
    }
    
    func getTableView() -> UITableView {
        return self.tableView
    }
    
}
