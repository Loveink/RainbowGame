//
//  GameScreen.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit

final class GameScreen {
    
    weak var controller: UIViewController?
    
    func build() -> UIViewController {
        let presenter = GameScreenPresenter(storage: StorageService())
        let controller = GameScreenViewController()
        controller.presenter = presenter
        presenter.screen = self
        presenter.view = controller
        self.controller = controller
        
        return controller
    }
    
    func showResultsScreen() {
        controller?.navigationController?.pushViewController(ResultsViewController(), animated: true)
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
        let wordPosition: GameWordPosition
        let speed: String?
    }
}
