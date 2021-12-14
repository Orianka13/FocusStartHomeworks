//
//  DetailTableView.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import UIKit

protocol IDetailTableView {
    
    var onTouchedHandler: ((_ indexPath: IndexPath) -> Void)? { get set }
    
    var onTouchedButtonHandler: ((_ indexPath: IndexPath) -> Void)? { get set }
    
    var fillCellHandler: ((_ cell: DetailTableViewCell, _ indexPath: IndexPath) -> Void)? { get set}
    
    func getIndex() -> Int
    
}

final class DetailTableView: UIView {
    
    private enum Metrics {
        static let zeroSpacing = CGFloat(0)
        static let numberOfRowsInSection = Int(4)
    }
    
    private var tableView: UITableView = UITableView()
    
    var onTouchedHandler: ((_ indexPath: IndexPath) -> Void)?
    var onTouchedButtonHandler: ((_ indexPath: IndexPath) -> Void)?
    var fillCellHandler: ((_ cell: DetailTableViewCell, _ indexPath: IndexPath) -> Void)?
    
    private var index = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        
        self.addView()
        self.setConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: Private extension
private extension DetailTableView {
    
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
extension DetailTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Metrics.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        self.fillCellHandler?(cell, indexPath)
        cell.selectionStyle = .none
        
        return cell
    }
}

//MARK: UITableViewDelegate
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

//MARK: IDetailTableView
extension DetailTableView: IDetailTableView {
    
    func getIndex() -> Int {
        return self.index
    }
    
}
