//
//  GameResults.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//
import Foundation

class GameResults {

    private var results: [GameResult] = []
    
    func addResult(score: Int, totalWords: Int, time: Float, speed: Int) {
        let result = GameResult(score: score, totalWords: totalWords, speed: speed, time: time)
        
        if results.count == 20 {
            results.removeFirst()
        }
        results.insert(result, at: 0)   
    }

    func getResults() -> [GameResult] {
        if results.count != 0 {
            var index = 0
            results[0].orderNumber = 1
            
            for number in 1...results.count {
                results[index].orderNumber = number
                index += 1
            }
        }
        return results
    }
    
    func getBestResult() -> String{
        var precision = 0
        var totalWords = 0
        var currentScore = 0
        for result in results {
            if result.score/result.totalColors > precision {
                currentScore = result.score
                totalWords = result.totalColors
            }
        }
        return "\(currentScore)/\(totalWords)"
    }

    func clearResults() {
        results.removeAll()
    }
}
