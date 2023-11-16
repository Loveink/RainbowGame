//
//  UIApplication+Extension.swift
//  RainbowGame
//
//  Created by Victor on 13.11.2023.
//

import UIKit

extension UIApplication {
    static var safeAreaInsets: UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window,
              let safeAreaInsets = window?.safeAreaInsets else {
            return .zero
        }
        return safeAreaInsets
    }
}
