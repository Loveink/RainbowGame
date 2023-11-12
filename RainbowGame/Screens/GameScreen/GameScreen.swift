//
//  GameScreen.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit

struct GameScreen {
    func build() -> UIViewController {
        let presenter = GameScreenPresenter()
        let controller = GameScreenViewController()
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}

extension GameScreen {
    struct Color {
        let text: String
        let textColor: UIColor
        let frame: Frame?
        let didSelectHandler: (() -> Void)?
    }
    
    struct Frame {
        let color: UIColor
    }
    struct ViewModel {
        let color: Color?
    }
}
