//
//  CompanyTableView.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import UIKit

protocol ICompanyTableView {
    
    func appendData(data: CompanyModel)
    var setCompanyNameHandler: ((CompanyModel) -> Data)? { get set }
}

final class CompanyTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        
    }
    
    private var tableView: UITableView = UITableView()
  
    private var data = [CompanyModel]()
    
    var setCompanyNameHandler: ((CompanyModel) -> Data)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        
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
        
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell
        let item = data[indexPath.row]
        if let data = setCompanyNameHandler?(item) {
            //cell.textLabel?.text = data.description
        }
        cell.selectionStyle = .none
        
        return cell
    }
}


//MARK: ICompanyTableView
extension CompanyTableView: ICompanyTableView {
    
    func appendData(data: CompanyModel) {
        self.data.append(data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
