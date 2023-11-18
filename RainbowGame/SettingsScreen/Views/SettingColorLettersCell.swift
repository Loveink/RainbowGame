//
//  SettingColorLettersCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//

import UIKit

final class SettingColorLettersCell: SettingsCollectionCellView {
    
    static let id = "settingColorLettersCell"
    
    var selectColorHandler: (([Int]) -> Void)?
    
    private let titleLabel = UILabel()
    private var buttons = [SettingsColorButton]()
    private var buttonStacks = [UIStackView]()
    private let stack = UIStackView()
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    private var selectedColors = Set<Int>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .white
        titleLabel.font = Fonts.text
        titleLabel.textColor = Colors.Interface.grayText
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        
        titleLabel.text = "Цвет букв"
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(stack)
        let view = UIView()
        view.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        [titleLabel, view].forEach {stack.addArrangedSubview($0)}
        
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fill
        stack.alignment = .fill
        
        stack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
    
    func configure(title: String, colors: [UIColor], selectedColors: [UIColor]) {
        titleLabel.text = title
        
        buttons = colors.enumerated().map {
            let button = SettingsColorButton()
            button.snp.makeConstraints {
                $0.size.equalTo(25)
            }
            button.backgroundColor = $1
            button.tag = $0
            button.isSelected = selectedColors.contains($1)
            if selectedColors.contains($1) {
                self.selectedColors.insert($0)
            }
            button.addTarget(self, action: #selector(didTapColor(_:)), for: .touchUpInside)
            return button
        }
        
        vStack.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        buttonStacks = []
        
        let rows = buttons.count / 4 + (buttons.count % 4 == 0 ? 0 : 1)
        for row in (0..<rows) {
            let hStack = UIStackView()
            hStack.spacing = 2
            (0..<4).forEach {
                let index = row * 4 + $0
                guard index < buttons.count else {
                    return
                }
                hStack.addArrangedSubview(buttons[index])
            }
            vStack.addArrangedSubview(hStack)
        }
    }
    
    @objc
    private func didTapColor(_ sender: UIButton) {
        defer {
            selectColorHandler?(Array(selectedColors))
        }
        
        guard !sender.isSelected else {
            if selectedColors.count < 3 {
                return
            }
            sender.isSelected = false
            selectedColors.remove(sender.tag)
            return
        }
        sender.isSelected = true
        selectedColors.insert(sender.tag)
    }
}
