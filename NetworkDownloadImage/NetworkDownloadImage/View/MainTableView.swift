//
//  MainTableView.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

protocol IMainTableView {
    
    
}

final class MainTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
    
    }
    
    private var tableView: UITableView = UITableView()
    
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
private extension MainTableView {
    
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
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as! TableViewCell

        cell.selectionStyle = .none
        
        return cell
    }
}


//MARK: IMainTableView
extension MainTableView: IMainTableView {
    

    
}
