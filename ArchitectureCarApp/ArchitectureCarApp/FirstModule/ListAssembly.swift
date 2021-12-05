//
//  ListAssembly.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

final class ListAssembly {
    
    static func build() -> UIViewController {
        
        let model = ListModel()
        let router = ListRouter()
        
        let presenter = ListPresenter(dependencies: .init(model: model, router: router))
        let controller = ListViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
