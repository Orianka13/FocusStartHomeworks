//
//  EmployeeAssembly.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 17.12.2021.
//

import UIKit

final class EmployeeAssembly {
    
    static func build(companyUid: UUID) -> EmployeeViewController {
        
        let presenter = EmployeePresenter(companyUid: companyUid)
        let controller = EmployeeViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
