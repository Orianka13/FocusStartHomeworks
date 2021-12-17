//
//  EmployeeTableView.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit

protocol IEmployeeTableView {
    
    func appendData(data: EmployeeModel)
    var setCompanyNameHandler: ((EmployeeModel) -> Data)? { get set }
    func reloadTableView()
}

final class EmployeeTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        
    }
    
    private var tableView: UITableView = UITableView()
  
    private var data = [EmployeeModel]()
    var setCompanyNameHandler: ((EmployeeModel) -> Data)?
    
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
        
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        let item = data[indexPath.row]
        //cell.textLabel?.text = item.getName()
        cell.selectionStyle = .none
        
        return cell
    }
}


//MARK: ICompanyTableView
extension EmployeeTableView: IEmployeeTableView {
    
    func appendData(data: EmployeeModel) {
        self.data.append(data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadDataArray(array: [EmployeeModel]){
        self.data = array
    }
    
    func reloadTableView(){
        self.tableView.reloadData()
    }
    
}
