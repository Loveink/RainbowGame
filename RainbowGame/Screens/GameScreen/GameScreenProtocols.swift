//
//  GameScreenProtocols.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit

protocol GameScreenInput: RainbowViewController {
    func updateTitle(_ text: String)
    func updateWith(_ viewModel: GameScreen.ViewModel)
    func updateSpeed(_ value: String)
    func updateGameState(_ state: GameScreen.GameState)
}

protocol GameScreenOutput: AnyObject {
    func activate()
    func play()
    func pause()
}

protocol GameScreenDelegate: AnyObject {
    func didTapPlay(_ vc: GameScreenInput)
    func didTapPause(_ vc: GameScreenInput)
}
