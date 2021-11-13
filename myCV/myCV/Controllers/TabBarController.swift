//
//  UITabBarController.swift
//  myCV
//
//  Created by Олеся Егорова on 12.11.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        
        view.backgroundColor = .white
        
        let firstViewController = InfoViewController()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 0)
        let secondViewController = ExperienceViewController()
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bag"), tag: 1)
        let thirdViewController = HobbiesViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "sun.max"), tag: 2)
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }

}
