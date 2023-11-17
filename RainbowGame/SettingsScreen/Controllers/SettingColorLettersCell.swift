//
//  SettingColorLettersCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//

import UIKit

final class SettingColorLettersCell: UICollectionViewCell {
	
	static let id = "settingColorLettersCell"
	
	//	var segmentedControlValueChanged: ((Int) -> Void)?
	
	private let titleLabel = UILabel()
	private let buttonRed = CustomButtonCell(backgroundColor: .red)
	private let buttonBlue = CustomButtonCell(backgroundColor: .blue)
	private let buttonYellow = CustomButtonCell(backgroundColor: .yellow)
	private let buttonGreen = CustomButtonCell(backgroundColor: .green)
	private let buttonPurple = CustomButtonCell(backgroundColor: .purple)
	
	
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
		
		titleLabel.text = "Цвет букв"
		
		addSubview(stack)
		
		[titleLabel, buttonRed, buttonBlue, buttonYellow, buttonGreen, buttonPurple].forEach {stack.addArrangedSubview($0)}
	
		stack.axis = .horizontal
		stack.spacing = 8
		stack.distribution = .fill
		stack.alignment = .center

		
		stack.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
			stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
			stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
			stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
		])
		
	//	segmetedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
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

