//
//  SettingBackgroundCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 14.11.2023.
//

import UIKit

final class SettingBackgroundCell: UICollectionViewCell {
	
	static let id = "settingBackgroundCell"
	
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
		
		switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
	}
	
	func configure(with title: String) {
		titleLabel.text = title
	}
	
	@objc private func switchValueChanged() {
		//print("Switch value changed to \(switchControl.isOn)")
	}
}
