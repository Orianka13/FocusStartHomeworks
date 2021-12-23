//
//  MainAssembly.swift
//  NetworkDownloadImage
//
//  Created by Олеся Егорова on 10.12.2021.
//

import UIKit

final class MainAssembly {
    
    static func build() -> UIViewController {
        
        let network = NetworkService()
        
        let presenter = MainPresenter(dependencies: .init(network: network))
        let controller = MainViewController(dependencies: .init(presenter: presenter))
        
        return controller
    }
}
