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
        let fontSize: CGFloat
        let frame: Frame?
        let didSelectHandler: (() -> Void)?
    }
    
    struct Frame {
        let color: UIColor
    }
    struct ViewModel {
        let backgroundColor: UIColor
        let color: Color?
        let wordPosition: GameWordPosition
        let speed: String?
        let speedClosure: (() -> Void)?
    }
}

extension GameScreen {
    enum GameState {
        case plaing
        case paused
    }
}
