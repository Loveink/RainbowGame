//
//  SettingsViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit

final class SettingsViewController: RainbowViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    enum Settings: Int, CaseIterable {
        case gameTime
        case cardChangeSpeed
        case coloredFrame
        case fontSize
        case withChecks
        case wordPosition
        case theme
        case wordColor
        
        var title: String {
            switch self {
            case .gameTime:
                return "Время игры, мин"
            case .cardChangeSpeed:
                return "Скорость игры, сек"
            case .coloredFrame:
                return "Подложка для букв"
            case .fontSize:
                return "Размер букв"
            case .withChecks:
                return "Проверка заданий"
            case .wordPosition:
                return "Расположение слова на экране"
            case .theme:
                return "Цвет фона"
            case .wordColor:
                return "Цвет букв"
            }
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: configureLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    private let storage: SettingsStorage = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Настройки"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Settings.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.backgroundColor = Colors.Interface.background
        guard let setting = Settings(rawValue: indexPath.item) else {
            return UICollectionViewCell()
        }
        switch setting {
        case .gameTime:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSliderCell.id, for: indexPath) as! SettingsSliderCell
            cell.configure(title: setting.title, minValue: 1, maxValue: 20, currentValue: storage.gameTime/60)
            cell.sliderDidChange = {
                [weak self] value in
                
              self?.storage.gameTime = value * 60
            }
            return cell
            
        case .cardChangeSpeed:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSliderCell.id, for: indexPath) as! SettingsSliderCell
            cell.configure(title: setting.title, minValue: 1, maxValue: 4, currentValue: storage.cardChangeSpeed)
            cell.sliderDidChange = {
                [weak self] value in
                
                self?.storage.cardChangeSpeed = value
            }
            return cell
            
        case .coloredFrame:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSwitchCell.id, for: indexPath) as! SettingsSwitchCell
            cell.configure(with: setting.title, value: storage.coloredFrame)
            cell.switchDidChange = {
                [weak self] value in
                
                self?.storage.coloredFrame = value
            }
            return cell
            
        case .fontSize:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingFontSizeCell.id, for: indexPath) as! SettingFontSizeCell
            cell.configure(with: "Размер букв", value: storage.fontSize)
            cell.stepperDidChange = {
                [weak self] value in
                
                self?.storage.fontSize = value
            }
            return cell
            
        case .withChecks:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSwitchCell.id, for: indexPath) as! SettingsSwitchCell
            cell.configure(with: setting.title, value: storage.withChecks)
            cell.switchDidChange = {
                [weak self] value in
                
                self?.storage.withChecks = value
            }
            return cell
            
        case .wordPosition:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSegmentCell.id, for: indexPath) as! SettingsSegmentCell
            cell.configure(title: setting.title, segments: GameWordPosition.allCases.map { $0.string }, selectedSegment: GameWordPosition.allCases.firstIndex(of: storage.wordPosition) ?? 0)
            cell.segmentedControlValueChanged = {
                [weak self] value in
                
                self?.storage.wordPosition = GameWordPosition.allCases[value]
            }
            return cell
            
        case .theme:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingsSegmentCell.id, for: indexPath) as! SettingsSegmentCell
            cell.configure(title: setting.title, segments: GameTheme.allCases.map { $0.string }, selectedSegment: GameTheme.allCases.firstIndex(of: storage.theme) ?? 0)
            cell.segmentedControlValueChanged = {
                [weak self] value in
                
                self?.storage.theme = GameTheme.allCases[value]
            }
            return cell
            
        case .wordColor:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingColorLettersCell.id, for: indexPath) as! SettingColorLettersCell
            cell.configure(title: setting.title, colors: GameColor.allCases.map { $0.color }, selectedColors: storage.colors.map { $0.color })
            cell.selectColorHandler = {
                [weak self] selectedColors in
                
                self?.storage.colors = selectedColors.compactMap { GameColor.allCases[$0] }
            }
            return cell
        }
    }
    
    private func configure() {
        view.backgroundColor = Colors.Interface.background
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.contentInset = .init(top: 8, left: 0, bottom: 0, right: 0)
        
        collectionView.register(SettingsSegmentCell.self, forCellWithReuseIdentifier: SettingsSegmentCell.id)
        collectionView.register(SettingsSliderCell.self, forCellWithReuseIdentifier: SettingsSliderCell.id)
        collectionView.register(SettingsSwitchCell.self, forCellWithReuseIdentifier: SettingsSwitchCell.id)
        collectionView.register(SettingFontSizeCell.self, forCellWithReuseIdentifier: SettingFontSizeCell.id)
        collectionView.register(SettingColorLettersCell.self, forCellWithReuseIdentifier: SettingColorLettersCell.id)
    }
    
    private func configureLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let defaultSize = CGSize(width: view.frame.width - 32 * 2, height: 80)
        guard let setting = Settings(rawValue: indexPath.item) else {
            return defaultSize
        }
        switch setting {
        case .wordColor:
            let rows = GameColor.allCases.count / 4 + (GameColor.allCases.count % 4 == 0 ? 0 : 1)
            let height = CGFloat(8 * 2 + rows * 25 + (rows - 1) * 2)
            return CGSize(width: view.frame.width - 32 * 2 + 3 * 2, height: height)
        default:
            return defaultSize
        }
    }
}
