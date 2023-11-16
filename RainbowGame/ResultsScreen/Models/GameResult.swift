//
//  GameResult.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

import Foundation

struct GameResult: Codable {
    let speed: Int
    let time: Int
    let score: Int
    let totalWords: Int
    let orderNumber: Int

    init(score: Int, totalWords: Int, speed: Int, time: Int, orderNumber: Int) {
        self.speed = speed
        self.time = time
        self.score = score
        self.totalWords = totalWords
        self.orderNumber = orderNumber
    }
}
