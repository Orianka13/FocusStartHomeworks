//
//  DetailTableView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import UIKit

final class DetailTableView: UIView {
    
    private var tableView: UITableView = UITableView()
    
    var onTouchedHandler: ((_ indexPath: IndexPath) -> Void)?
    var onTouchedButtonHandler: ((_ indexPath: IndexPath) -> Void)?
    var fillCellHandler: ((_ cell: DetailTableViewCell, _ indexPath: IndexPath) -> Void)?
    
    var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        self.addView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addView() {
        self.addSubview(self.tableView)
    }
    
    private func setConstraint() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
    }
}

extension DetailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        self.fillCellHandler?(cell, indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
    
}

extension DetailTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        tableView.indexPathForSelectedRow?.forEach {_ in
            if let cell = tableView.cellForRow(at: indexPath) as? DetailTableViewCell {
                cell.setOnImage()
                self.onTouchedHandler?(indexPath)
                self.index = indexPath.row
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? DetailTableViewCell {
            
            cell.setOffImage()
        }
    }
}
