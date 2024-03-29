//
//  CompanyView.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 16.12.2021.
//

import UIKit

protocol ICompanyView {
    func getTableView() -> CompanyTableView
    var onTouchedHandler: ((String) -> Void)? { get set }
}

final class CompanyView: UIView {
    
    private enum Metrics {
        static var standartSpacing = CGFloat(20)
        static var tableViewHeight = CGFloat(1.2)
    }
    
    
    private var tableView = CompanyTableView()
    
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
private extension CompanyView {
    
    func addView() {
        self.addSubview(tableView)
    }
    func setConstraint() {
        self.makeTableViewConstraints()
    }
    
    func makeTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Metrics.standartSpacing).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Metrics.standartSpacing).isActive = true
        self.tableView.heightAnchor.constraint(equalToConstant: self.frame.size.height / Metrics.tableViewHeight).isActive = true
    }
}

//MARK: ICompanyView
extension CompanyView: ICompanyView {
    
    func getTableView() -> CompanyTableView {
        return self.tableView
    }
}
