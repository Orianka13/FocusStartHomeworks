//
//  Assembly.swift
//  Architecture
//
//  Created by Олеся Егорова on 29.11.2021.
//

import UIKit

final class Assembly {
    static func build(film: Film) -> UIViewController {
        let filmModel = FilmModel(film: film)
        let presenter = CustomPresenter(film: filmModel)
        let controller = SecondViewController(presenter: presenter)
        
        return controller
    }
}
