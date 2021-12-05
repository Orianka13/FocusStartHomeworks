//
//  ListRouter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import Foundation
import UIKit

final class ListRouter {
    
    private var controller: ListViewController?
//    private var targertController: DetailViewController?

//    func setRootVC(controller: ListViewController) {
//        self.controller = controller
//    }
//
//    func setTargetVC(controller: DetailViewController) {
//        self.targertController = controller
//    }

    func next(currentVC: UIViewController, nextVC: UIViewController) {
        currentVC.navigationController?.pushViewController(nextVC, animated: true)
        //self.controller?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
