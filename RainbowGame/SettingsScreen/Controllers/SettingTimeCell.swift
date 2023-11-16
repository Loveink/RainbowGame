//
//  SettingTimeCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 14.11.2023.
//

import UIKit

final class SettingTimeCell: UICollectionViewCell {
    
    static let id = "settingTimeCell"
    
    var sliderDidChange: ((Int) -> Void)?
    
    private let titleLabel = UILabel()
    private let slider = UISlider()
    private let valueLabel = UILabel()
    
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
        
        slider.minimumValue = 1
        slider.maximumValue = 20
        valueLabel.text = "\(Int(slider.value))"
        
        addSubview(stack)
        
        [titleLabel, slider, valueLabel].forEach { stack.addArrangedSubview($0)}
        
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    func configure(with title: String, value: Int) {
        titleLabel.text = title
        valueLabel.text = "\(value)"
        slider.value = Float(value)
    }
    
    @objc private func sliderValueChanged() {
        valueLabel.text = "\(Int(slider.value))"
        sliderDidChange?(Int(slider.value))
    }
}
