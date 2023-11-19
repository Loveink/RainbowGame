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
    private lazy var colorChangeTime = storage.cardChangeSpeed
    private lazy var gameSpeed = storage.cardChangeSpeed {
        didSet {
            if gameSpeed > 4 {
                gameSpeed = 1
            }
        }
    }
    
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
    
    func play() {
        if gameSpeed != storage.cardChangeSpeed {
            colorChangeTime = gameSpeed
            if interColorTime > colorChangeTime {
                interColorTime = 0
            }
            storage.cardChangeSpeed = gameSpeed
        }
        
        start(new: false)
    }
    
    func pause() {
        guard let timer else {
            return
        }
        timer.invalidate()
        self.timer = nil
        view?.updateGameState(.paused)
    }
    
    private func start(new: Bool) {
        
        view?.updateGameState(.plaing)
        
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
        view?.updateTitle(formattedTime(time: remaningTime))
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
                    time: Float(roundTime)
        
                )
            )
            screen?.showResultsScreen()
            return
        }
        remaningTime -= 1
        view?.updateTitle(formattedTime(time: remaningTime))

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
                backgroundColor: storage.theme.color,
                color: .init(
                    text: randomColor.fakeColor.name,
                    textColor: storage.coloredFrame ? .white : randomColor.color,
                    fontSize: CGFloat(storage.fontSize),
                    frame: storage.coloredFrame ? .init(color: randomColor.color) : nil,
                    didSelectHandler: storage.withChecks ? {
                        [weak self] in
                        
                        self?.roundPoints += 1
                    } : nil
                ),
                wordPosition: storage.wordPosition,
                speed: "\(gameSpeed)c",
                speedClosure: {
                    [weak self] in
                    
                    guard let self else { return }
                    
                    self.pause()
                    self.view?.updateGameState(.paused)
                    self.gameSpeed += 1
                    self.view?.updateSpeed("\(self.gameSpeed)c")
                }
            )
        )
    }

  private func formattedTime(time: Int) -> String {
      let minutes = time / 60
      let seconds = time % 60
      return String(format: "%02d:%02d", minutes, seconds)
  }
}

extension GameColor {
    var fakeColor: Self {
        GameColor.allCases.filter { $0 != self }.randomElement()!
    }
}
