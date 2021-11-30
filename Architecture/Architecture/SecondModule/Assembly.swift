//
//  Assembly.swift
//  Architecture
//
//  Created by Олеся Егорова on 29.11.2021.
//

import UIKit

final class Assembly {
    
    static func build(film: Film) -> UIViewController {
        
        let filmModel = PosterModel(film: film)
        let presenter = PosterPresenter(film: filmModel)
        let controller = PosterViewController(presenter: presenter)
        
        return controller
    }
}
