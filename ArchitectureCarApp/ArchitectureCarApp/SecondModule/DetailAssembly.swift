//
//  DetailAssembly.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 02.12.2021.
//

import UIKit

final class DetailAssembly {
    
    static func build() -> UIViewController {
        
        let model = DetailModel()
        let router = DetailRouter()
        
        let presenter = DetailPresenter(dependencies: .init(model: model, router: router))
        let controller = DetailViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
