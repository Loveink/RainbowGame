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
        let fontSize: CGFloat
        let frameColor: UIColor?
        let didSelectHandler: (() -> Void)?
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 10
        static let titleInsets: UIEdgeInsets = .init(top: 8, left: 6, bottom: 8, right: 6)
        static let markCirleSize: CGSize = .init(width: 29, height: 29)
        static let markCirleInset: CGFloat = 6
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
    
    private let markCircle: UIView = {
        let view = UIView()
//        view.backgroundColor = Colors.U
        view.layer.cornerRadius = Layout.markCirleSize.width / 2
        return view
    }()
    
    private let markView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.mark
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
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
        addSubview(markCircle)
        addSubview(markView)
        
        titleLabel.font = Fonts.font
        
        coloredView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.titleInsets.top)
            $0.bottom.equalToSuperview().inset(Layout.titleInsets.bottom)
            $0.leading.greaterThanOrEqualToSuperview().inset(Layout.titleInsets.left)
            $0.trailing.lessThanOrEqualTo(markCircle.snp.leading).inset(-Layout.titleInsets.right)
            $0.centerX.equalToSuperview().priority(.medium)
        }
        
        markCircle.snp.makeConstraints {
            $0.size.equalTo(Layout.markCirleSize)
            $0.trailing.equalToSuperview().inset(Layout.markCirleInset)
            $0.centerY.equalToSuperview()
        }
        
        markView.snp.makeConstraints {
            $0.edges.equalTo(markCircle)
        }
        
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tapGR.cancelsTouchesInView = false
        addGestureRecognizer(tapGR)
    }
    
    @objc
    private func didSelect() {
        selectHandler?()
        markView.isHidden = selectHandler == nil
    }
    
    func update(_ model: Model) {
        titleLabel.text = model.text
        titleLabel.textColor = model.textColor
        titleLabel.font = titleLabel.font.withSize(model.fontSize)
        selectHandler = model.didSelectHandler
        markCircle.isHidden = model.didSelectHandler == nil
        markView.isHidden = true
        
        
        if let frameColor = model.frameColor {
            coloredView.backgroundColor = frameColor
            coloredView.isHidden = false
        } else {
            coloredView.isHidden = true
        }
    }
}
