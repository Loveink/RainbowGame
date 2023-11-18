//
//  SettingsSwitchCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 14.11.2023.
//

import UIKit

final class SettingsSwitchCell: SettingsCollectionCellView {
    
    static let id = "SettingsSwitchCell"
    
    var switchDidChange: ((Bool) -> Void)?
    
    private let titleLabel = UILabel()
    private let switchControl = UISwitch()
    
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        titleLabel.font = Fonts.text
        titleLabel.textColor = Colors.Interface.grayText
        switchControl.onTintColor = Colors.Interface.blueText
        
        
        backgroundColor = .white
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
        contentView.addSubview(stack)
        
        [titleLabel, switchControl].forEach { stack.addArrangedSubview($0)}
        
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        stack.alignment = .center
        
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
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
