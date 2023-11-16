//
//  SettingBackgroundCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 14.11.2023.
//

import UIKit

final class SettingBackgroundCell: UICollectionViewCell {
    
    static let id = "settingBackgroundCell"
    
    var switchDidChange: ((Bool) -> Void)?
    
    private let titleLabel = UILabel()
    private let switchControl = UISwitch()
    
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
        addSubview(stack)
        
        [titleLabel, switchControl].forEach { stack.addArrangedSubview($0)}
        
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.alignment = .center
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
    }
    
    func configure(with title: String, value: Bool) {
        titleLabel.text = title
        switchControl.isOn = value
    }
    
    @objc private func switchValueChanged(_ switcher: UISwitch) {
        switchDidChange?(switcher.isOn)
    }
}
