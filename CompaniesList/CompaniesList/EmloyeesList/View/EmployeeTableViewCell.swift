//
//  EmployeeTableViewCell.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit


final class EmployeeTableViewCell: UITableViewCell {
    
    private enum Literal {
        static let cellId = "cell"
    }
    
    static let reuseIdentifier = Literal.cellId
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
