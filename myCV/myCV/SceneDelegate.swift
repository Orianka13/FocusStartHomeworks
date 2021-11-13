//
//  SceneDelegate.swift
//  myCV
//
//  Created by Олеся Егорова on 10.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let tabBarVC = TabBarController(nibName: "TabBarController", bundle: nil)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

