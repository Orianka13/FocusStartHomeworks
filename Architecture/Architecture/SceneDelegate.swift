//
//  SceneDelegate.swift
//  CollectionApp
//
//  Created by Олеся Егорова on 17.11.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        
        let layoutVC = CollectionViewController()
        let navVC = UINavigationController(rootViewController: layoutVC)
        
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        navVC.navigationBar.barTintColor = .black
        
        self.window?.rootViewController = navVC
        self.window?.makeKeyAndVisible()
    }
}

