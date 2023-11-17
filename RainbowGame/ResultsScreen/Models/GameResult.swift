//
//  GameResult.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

import Foundation

struct GameResult {
    let speed: Int
    let time: Float
    let score: Int
    let totalColors: Int
    var orderNumber: Int

    init(score: Int, totalWords: Int, speed: Int, time: Float) {
        self.speed = speed
        self.time = time
        self.score = score
        self.totalColors = totalWords
        self.orderNumber = 0
    }
}
