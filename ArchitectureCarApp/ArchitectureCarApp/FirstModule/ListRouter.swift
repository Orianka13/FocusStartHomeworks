//
//  ListRouter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import Foundation
import UIKit

final class ListRouter {
    
    func next(cars: [Car], controller: ListViewController) {
        
        let targetController = DetailAssembly.build(cars: cars)
        
        controller.navigationController?.pushViewController(targetController, animated: true)
    }
}



