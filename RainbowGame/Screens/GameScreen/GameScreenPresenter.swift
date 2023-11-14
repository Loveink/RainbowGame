//
//  GameLogic.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit

final class GameScreenPresenter: GameScreenOutput {
    var screen: GameScreen?
    weak var view: GameScreenInput?
    
    private let storage: GameStorage
    private lazy var colors: [GameColor] = storage.colors
    private lazy var roundTime: Int = storage.gameTime
    private lazy var colorChangeTime = 2 * storage.cardChangeSpeed
    
    private var remaningTime = 0
    private var interColorTime = 0
    private var roundPoints = 0
    
    private var timer: Timer?
    private var previousColor: GameColor?
    private var randomColor: GameColor {
        var randomColor = colors.randomElement()!
        while randomColor == previousColor {
            randomColor = colors.randomElement()!
        }
        previousColor = randomColor
        return randomColor
    }
    
    init(storage: GameStorage) {
        self.storage = storage
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func activate() {
        start(new: true)
    }
    
    func pause() {
        guard let timer else {
            start(new: false)
            return
        }
        timer.invalidate()
        self.timer = nil
    }
    
    private func start(new: Bool) {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true,
            block: {
                [weak self] _ in
                
                self?.timerFired()
            }
        )
        
        guard new else {
            return
        }
        
        roundPoints = 0
        remaningTime = roundTime
        interColorTime = colorChangeTime
        view?.updateTitle("\(remaningTime)")
        updateColor()
    }
    
    private func timerFired() {
        if remaningTime <= 1 {
            timer?.invalidate()
            timer = nil
            storage.addResult(
                .init(
                    score: roundPoints,
                    totalWords: roundTime / colorChangeTime,
                    speed: colorChangeTime,
                    time: roundTime,
                    orderNumber: storage.results.count + 1
                )
            )
            screen?.showResultsScreen()
            return
        }
        remaningTime -= 1
        view?.updateTitle("\(remaningTime)")
        
        interColorTime -= 1
        if interColorTime <= 0 {
            updateColor()
            interColorTime = colorChangeTime
        }
    }
    
    private func updateColor() {
        let randomColor = self.randomColor
        view?.updateWith(
            .init(
                color: .init(
                    text: randomColor.fakeColor.name,
                    textColor: storage.coloredFrame ? .white : randomColor.color,
                    frame: storage.coloredFrame ? .init(color: randomColor.color) : nil,
                    didSelectHandler: storage.withChecks ? {
                        [weak self] in
                        
                        self?.roundPoints += 1
                    } : nil
                ),
                speed: storage.cardChangeSpeed > 1 ? "x\(storage.cardChangeSpeed)" : nil
            )
        )
    }
}

extension GameColor {
    var fakeColor: Self {
        GameColor.allCases.filter { $0 != self }.randomElement()!
    }
}
