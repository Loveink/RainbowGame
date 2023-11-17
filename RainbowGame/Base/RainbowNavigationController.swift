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
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 30), .foregroundColor: UIColor().getDarkBlueColor()]
        appearance.setBackIndicatorImage(Images.arrowLeft, transitionMaskImage: Images.arrowLeft)

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactScrollEdgeAppearance = appearance
        
        navigationBar.tintColor = Colors.black
    }
}
