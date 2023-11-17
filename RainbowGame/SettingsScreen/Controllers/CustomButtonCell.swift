//
//  CustomButtonCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//
import UIKit

final class CustomButtonCell: UIButton {
	
	init(backgroundColor: UIColor) {
		super.init(frame: .zero)
		
		setupButton(backgroundColor: backgroundColor)

	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupButton(backgroundColor: UIColor) {
		
		self.backgroundColor = backgroundColor
		
		heightAnchor.constraint(equalToConstant: 20).isActive = true
		widthAnchor.constraint(equalToConstant: 20).isActive = true
		
	}
}
