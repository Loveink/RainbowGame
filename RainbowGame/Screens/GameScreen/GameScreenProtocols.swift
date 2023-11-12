//
//  GameScreenProtocols.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit

protocol GameScreenInput: UIViewController {
    func updateTitle(_ text: String)
    func updateWith(_ viewModel: GameScreen.ViewModel)
}

protocol GameScreenOutput: AnyObject {
    func activate()
}
