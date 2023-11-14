//
//  GameResult.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

import Foundation

struct GameResult {
    let speed: Int
    let time: String
    let score: Int
    let totalWords: Int
    var orderNumber: Int

    init(score: Int, totalWords: Int, speed: Int, time: String) {
        self.speed = speed
        self.time = time
        self.score = score
        self.totalWords = totalWords
        self.orderNumber = 0
    }
}
