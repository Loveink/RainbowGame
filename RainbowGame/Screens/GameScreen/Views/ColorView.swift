//
//  ColorView.swift
//  RainbowGame
//
//  Created by Victor on 12.11.2023.
//

import UIKit
import SnapKit

final class ColorView: UIView {
    
    struct Model {
        let text: String
        let textColor: UIColor
        let frameColor: UIColor?
        let didSelectHandler: (() -> Void)?
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 10
        static let titleInsets: UIEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    private let coloredView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = .init(width: 0, height: 4)
        view.layer.shadowOpacity = 0.25
        view.isHidden = true
        return view
    }()
    
    private let titleLabel = UILabel()
    private var selectHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        addSubview(coloredView)
        addSubview(titleLabel)
        
        titleLabel.font = Fonts.Cards.font
        
        coloredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.titleInsets.top)
            $0.bottom.equalToSuperview().inset(Layout.titleInsets.bottom)
            $0.leading.greaterThanOrEqualToSuperview().inset(Layout.titleInsets.left)
            $0.trailing.lessThanOrEqualToSuperview().inset(Layout.titleInsets.right)
            $0.centerX.equalToSuperview()
        }
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tapGR.cancelsTouchesInView = false
        addGestureRecognizer(tapGR)
    }
    
    @objc
    private func didSelect() {
        selectHandler?()
    }
    
    func update(_ model: Model) {
        titleLabel.text = model.text
        titleLabel.textColor = model.textColor
        selectHandler = model.didSelectHandler
        
        if let frameColor = model.frameColor {
            coloredView.backgroundColor = frameColor
            coloredView.isHidden = false
        } else {
            coloredView.isHidden = true
        }
    }
}
