//
//  NavigationController.swift
//  RainbowGame
//
//  Created by Victor on 13.11.2023.
//

import UIKit

final class RainbowNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Colors.Background.lvl1
        
        appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 30)]
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactScrollEdgeAppearance = appearance
        
        navigationBar.tintColor = Colors.mainText
    
    }
}
