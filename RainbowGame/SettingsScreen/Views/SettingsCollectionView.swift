//
//  SettingsCollectionView.swift
//  RainbowGame
//
//  Created by Victor on 18.11.2023.
//

import UIKit

class SettingsCollectionCellView: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    func configure() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = .init(width: 0, height: 4)
        layer.shadowOpacity = 0.25
    }
    
}
