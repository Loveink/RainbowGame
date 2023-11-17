//
//  SettingFontSizeCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//

import UIKit

final class SettingFontSizeCell: UICollectionViewCell {
	
	static let id = "settingFontSizeCell"
	
	var stepperDidChange: ((Int) -> Void)?
	
	private let titleLabel = UILabel()
	private let fontSizeStepper = UIStepper()
	private let fontSizeLabel = UILabel()
	
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
		
		fontSizeStepper.minimumValue = 15
		fontSizeStepper.maximumValue = 20
		fontSizeLabel.text = "aA"
		
		addSubview(stack)
		
		[titleLabel, fontSizeStepper, fontSizeLabel].forEach { stack.addArrangedSubview($0)}
		
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
		
		fontSizeStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
	}
	
	func configure(with title: String, value: Int) {
		titleLabel.text = title
		fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(value))
		fontSizeStepper.value = CGFloat(value)
	}
	
	@objc private func stepperValueChanged(_ stepper: UIStepper) {
		fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(stepper.value))
		stepperDidChange?(Int(stepper.value))
	}
}
