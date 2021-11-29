//
//  ThirdViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class ThirdViewController: UIViewController {
    
    private enum Constants {
        static let mainBackgroundColor: UIColor = .darkGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.mainBackgroundColor
    }
    
    private func setHandlers(){
        let view = DescriptionView()
        view.onTouchedHandler = {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
