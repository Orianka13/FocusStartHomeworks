//
//  EmployeeAssembly.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit

final class EmployeeAssembly {
    
    static func build() -> EmployeeViewController {
        
        let presenter = EmployeePresenter()
        let controller = EmployeeViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
