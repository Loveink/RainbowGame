//
//  CustomButtonCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//
import UIKit

final class SettingsColorButton: UIButton {
	
    private let selectedImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = Images.mark.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .white
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            selectedImageView.isHidden = !isSelected
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
