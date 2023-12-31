//
//  SceneDelegate.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }

      let rootViewController = RainbowNavigationController(rootViewController: MainViewController())

    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()
  }
}
