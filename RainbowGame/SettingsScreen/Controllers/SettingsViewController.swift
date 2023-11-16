//
//  SettingsViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit

final class SettingsViewController: RainbowViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private var collectionView: UICollectionView!
    private let storage: SettingsStorage = StorageService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionLayout()
        title = "Настройки"
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingTimeCell.id, for: indexPath) as! SettingTimeCell
            cell.configure(with: "Время игры, мин", value: storage.gameTime)
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
            cell.sliderDidChange = {
                [weak self] value in
                
                self?.storage.gameTime = value
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingSpeedCell.id, for: indexPath) as! SettingSpeedCell
            cell.configure(with: "Скорость, сек", value: storage.cardChangeSpeed)
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
            cell.sliderDidChange = {
                [weak self] value in
                
                self?.storage.cardChangeSpeed = value
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SettingBackgroundCell.id, for: indexPath) as! SettingBackgroundCell
            cell.configure(with: "Подложка для букв", value: storage.coloredFrame)
            cell.layer.cornerRadius = 20
            cell.clipsToBounds = true
            cell.switchDidChange = {
                [weak self] isOn in
                
                self?.storage.coloredFrame = isOn
            }
            return cell
        default:
            fatalError("Unexpected cell index")
        }
    }
    
    private func setupCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width * 0.8, height: view.frame.height * 0.1)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(SettingTimeCell.self, forCellWithReuseIdentifier: SettingTimeCell.id)
        collectionView.register(SettingSpeedCell.self, forCellWithReuseIdentifier: SettingSpeedCell.id)
        collectionView.register(SettingBackgroundCell.self, forCellWithReuseIdentifier: SettingBackgroundCell.id)
        
        view.addSubview(collectionView)
    }
}
