//
//  ThirdViewController.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 18.11.2021.
//

import UIKit

final class ThirdViewController: UIViewController {
    
    private var descriptionView: DescriptionView

    private enum Constants {
        static let mainBackgroundColor: UIColor = .darkGray
    }
    
    init() {
        self.descriptionView = DescriptionView(frame: UIScreen.main.bounds)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(descriptionView)
        
        setHandlers()
        
        view.backgroundColor = Constants.mainBackgroundColor
    }
    
    private func setHandlers(){
        self.descriptionView.onTouchedHandler = {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
