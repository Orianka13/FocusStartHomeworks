//
//  UITabBarController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        
        view.backgroundColor = .white
        
        let infoVC = InfoViewController()
        infoVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 0)
        let experienceVC = ExperienceViewController()
        experienceVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bag"), tag: 1)
        let hobbiesVC = HobbiesViewController()
        hobbiesVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "sun.max"), tag: 2)
        viewControllers = [infoVC, experienceVC, hobbiesVC]
    }
}
