//
//  CustomButton.swift
//  RainbowGame
//
//  Created by Alex  on 13.11.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
	var customTitle: String? {
		didSet {
			setTitle(customTitle, for: .normal)
		}
	}
	
	var customBackgroundColor: UIColor? {
		didSet {
			backgroundColor = customBackgroundColor
		}
	}
    
    var customTitleColor: UIColor = .white {
        didSet {
            setTitleColor(customTitleColor, for: .normal)
        }
    }
	
	var customShadowColor: CGColor? {
		didSet {
			layer.shadowColor = customShadowColor 
		}
	}
		
    init(customTitle: String, customBackgroundColor: UIColor, customTitleColor: UIColor = .white, customShadowColor: CGColor) {
		super.init(frame: .zero)
		self.customTitle = customTitle
		self.customBackgroundColor = customBackgroundColor
        self.customTitleColor = customTitleColor
		self.customShadowColor = customShadowColor
		setupButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupButton() {
		self.backgroundColor = customBackgroundColor
		self.setTitle(customTitle, for: .normal)
		self.titleLabel?.font = .boldSystemFont(ofSize: 25)
        self.setTitleColor(customTitleColor, for: .normal)
		self.layer.shadowColor = customShadowColor
		self.layer.shadowOffset = CGSize(width: 0.0, height: 2.5)
		self.layer.shadowOpacity = 0.7
		self.layer.shadowRadius = 3.5
		self.layer.masksToBounds = false
		self.layer.cornerRadius = 25
		self.translatesAutoresizingMaskIntoConstraints = false
	}	
}


class CustomRoundButton: UIButton {
	var imageName: String? {
		didSet {
			updateImage()
		}
	}

	init(imageName: String) {
		super.init(frame: .zero)
		self.imageName = imageName
		setupButton()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupButton()
	}

	private func setupButton() {
		self.translatesAutoresizingMaskIntoConstraints = false
		updateImage()
	}

	private func updateImage() {
		guard let imageName = imageName else {
			setImage(nil, for: .normal)
			return
		}

		let config = UIImage.SymbolConfiguration(pointSize: 60, weight: .medium, scale: .large)
		let icon = UIImage(systemName: imageName, withConfiguration: config)
		setImage(icon, for: .normal)
		imageView?.contentMode = .scaleToFill
		tintColor = UIColor(red: 137/255, green: 68/255, blue: 171/255, alpha: 1.0)
		backgroundColor = .clear
		imageView?.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
		self.translatesAutoresizingMaskIntoConstraints = false
	}
}
