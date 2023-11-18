//
//  StorageService.swift
//  RainbowGame
//
//  Created by Victor on 14.11.2023.
//

import UIKit

enum GameColor: String, CaseIterable {
    case red, blue, yellow, green, purple, cian, brown, orange
    
    var name: String {
        switch self {
        case .red:
            return "Красный"
        case .blue:
             return "Синий"
        case .yellow:
            return "Желтый"
        case .green:
            return "Зеленый"
        case .purple:
            return "Фиолетовый"
        case .cian:
            return "Голубой"
        case .brown:
            return "Коричневый"
        case .orange:
            return "Оранжевый"
        }
    }
    
    var color: UIColor {
        switch self {
        case .red:
            return Colors.Cards.red
        case .blue:
            return Colors.Cards.blue
        case .yellow:
            return Colors.Cards.yellow
        case .green:
            return Colors.Cards.green
        case .purple:
            return Colors.Cards.purple
        case .cian:
            return Colors.Cards.cian
        case .brown:
            return Colors.Cards.brown
        case .orange:
            return Colors.Cards.orange
        }
    }
}

enum GameWordPosition: String, CaseIterable {
    case middle
    case random
    
    var string: String {
        switch self {
        case .middle:
           return "По центру"
        case .random:
            return "Случайное"
        }
    }
}

enum GameTheme: String, CaseIterable {
    case standart, white, black
    
    var string: String {
        switch self {
        case .standart:
            return "Стандартный"
        case .white:
            return "Белый"
        case .black:
            return "Черный"
        }
    }
    
    var color: UIColor {
        switch self {
        case .black:
            return .black
        case .standart:

            return Colors.Interface.background
        case .white:
            return .white
        }
    }
}

protocol SettingsStorage: AnyObject {
    var gameTime: Int { get set }
    var cardChangeSpeed: Int { get set }
    var withChecks: Bool { get set }
    var colors: [GameColor] { get set }
    var fontSize: Int { get set }
    var coloredFrame: Bool { get set }
    var theme: GameTheme { get set }
    var wordPosition: GameWordPosition { get set }
}

protocol ResultsStorage: AnyObject {
    var results: [GameResult] { get }
    
    func addResult(_ result: GameResult)
    func clearResults()
}

protocol GameStorage: ResultsStorage, SettingsStorage { }

final class StorageService: GameStorage {
    
    enum Keys: String {
        case gameTime
        case cardChangeSpeed
        case withChecks
        case colors
        case fontSize
        case coloredFrame
        case backgroundColor
        case wordPosition
        case results
    }
    
    var results: [GameResult] {
        guard let data = UserDefaults.standard.data(forKey: Keys.results.rawValue),
              let results = try? JSONDecoder().decode([GameResult].self, from: data) else {
            return []
        }
        return results
    }
    
    var gameTime: Int {
        get {
            UserDefaults.standard.integer(forKey: Keys.gameTime.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.gameTime.rawValue)
        }
    }
    
    var cardChangeSpeed: Int {
        get {
            UserDefaults.standard.integer(forKey: Keys.cardChangeSpeed.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.cardChangeSpeed.rawValue)
        }
    }
    
    var withChecks: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.withChecks.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.withChecks.rawValue)
        }
    }
    
    var colors: [GameColor] {
        get {
            (UserDefaults.standard.value(forKey: Keys.colors.rawValue) as! [String]).compactMap{ GameColor(rawValue: $0) }
        }
        
        set {
            UserDefaults.standard.setValue(newValue.map { $0.rawValue }, forKey: Keys.colors.rawValue)
        }
    }
    
    var fontSize: Int {
        get {
            UserDefaults.standard.integer(forKey: Keys.fontSize.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.fontSize.rawValue)
        }
    }
    
    var coloredFrame: Bool {
        get {
            UserDefaults.standard.bool(forKey: Keys.coloredFrame.rawValue)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: Keys.coloredFrame.rawValue)
        }
    }
    
    var theme: GameTheme {
        get {
            GameTheme(rawValue: UserDefaults.standard.string(forKey: Keys.backgroundColor.rawValue)!)!
        }
        
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: Keys.backgroundColor.rawValue)
        }
    }
    
    var wordPosition: GameWordPosition {
        get {
            GameWordPosition(rawValue: UserDefaults.standard.string(forKey: Keys.wordPosition.rawValue)!)!
        }
        
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: Keys.wordPosition.rawValue)
        }
    }
    
    init() {
        UserDefaults.standard.register(
            defaults: [
                Keys.gameTime.rawValue : 12,
                Keys.cardChangeSpeed.rawValue: 1,
                Keys.withChecks.rawValue: false,
                Keys.colors.rawValue: [GameColor.red, GameColor.blue, GameColor.green, GameColor.purple, GameColor.yellow].map { $0.rawValue },
                Keys.fontSize.rawValue: 20,
                Keys.coloredFrame.rawValue: true,
                Keys.backgroundColor.rawValue: GameTheme.standart.rawValue,
                Keys.wordPosition.rawValue: GameWordPosition.random.rawValue
            ]
        )
    }
    
    func addResult(_ result: GameResult) {
        let results = [result] + self.results
        if let encoded = try? JSONEncoder().encode(results) {
            UserDefaults.standard.setValue(encoded, forKey: Keys.results.rawValue)
        }
    }
    
    func clearResults() {
        UserDefaults.standard.setValue([], forKey: Keys.results.rawValue)
    }
}
