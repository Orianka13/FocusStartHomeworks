//
//  ListRouter.swift
//  ArchitectureCarApp
//
//  Created by Олеся Егорова on 05.12.2021.
//

import Foundation

final class ListRouter {
    
    private var controller: ListViewController?
    private var targertController: DetailViewController?

    func setRootVC(controller: ListViewController) {
        self.controller = controller
    }

    func setTargetVC(controller: DetailViewController) {
        self.targertController = controller
    }

    func next() {
        guard let targertController = self.targertController else {
            return
        }
        self.controller?.navigationController?.pushViewController(targertController, animated: true)
    }
}
