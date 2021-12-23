//
//  CompanyAssembly.swift
//  CompaniesList
//
//  Created by Олеся Егорова on 22.12.2021.
//

import Foundation
import UIKit

final class CompanyAssembly {
    
    
    static func build() -> CompanyViewController {
        
        let presenter = CompanyPresenter()
        let controller = CompanyViewController(dependencies: .init(presenter: presenter))
        
        return controller
        
    }
}
