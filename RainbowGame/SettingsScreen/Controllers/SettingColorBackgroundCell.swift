//
//  SettingColorBackgroundCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//

import UIKit

final class SettingColorBackgroundCell: UICollectionViewCell {
	
	static let id = "settingColorBackgroundCell"
	
	//	var segmentedControlValueChanged: ((Int) -> Void)?
	
	private let titleLabel = UILabel()
	private let segmetedControl = UISegmentedControl(items: ["Серый", "Белый", "Черный"])
	
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
		
		titleLabel.text = "Цвет фона"
		
		addSubview(stack)
		
		[titleLabel, segmetedControl].forEach { stack.addArrangedSubview($0)}
		
		stack.axis = .vertical
		stack.spacing = 16
		stack.distribution = .fill
		
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
		
		segmetedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
	}
	
	func configure(with title: String, value: Int) {
		//		titleLabel.text = title
		//		fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(value))
		//		fontSizeStepper.value = CGFloat(value)
	}
	
	@objc private func segmentedControlValueChanged(_ segmentControl: UISegmentedControl) {
		//		fontSizeLabel.font = UIFont.systemFont(ofSize: CGFloat(stepper.value))
		//		stepperDidChange?(Int(stepper.value))
	}
}

