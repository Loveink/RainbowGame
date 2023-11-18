//
//  SettingsSegmentCell.swift
//  RainbowGame
//
//  Created by Наталья Миронова on 17.11.2023.
//

import UIKit

final class SettingsSegmentCell: SettingsCollectionCellView {
    
    static let id = "SettingsSegmentCell"
    
    var segmentedControlValueChanged: ((Int) -> Void)?
    
    private let titleLabel = UILabel()
    private let segmentedControl = UISegmentedControl()
    
    private let stack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        titleLabel.textColor = Colors.Interface.grayText
        titleLabel.font = Fonts.text
        segmentedControl.selectedSegmentTintColor = Colors.Interface.blueText
        segmentedControl.setTitleTextAttributes([.foregroundColor: Colors.Interface.blue], for: .normal)
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
//        segmentedControl.layer.cornerRadius = 15

        
        backgroundColor = .white
        layer.cornerRadius = 25
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        addSubview(stack)
        
        [titleLabel, segmentedControl].forEach { stack.addArrangedSubview($0)}
        
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
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    func configure(title: String, segments: [String], selectedSegment: Int) {
        titleLabel.text = title
        segments.enumerated().forEach {
            segmentedControl.insertSegment(withTitle: $1, at: $0, animated: false)
        }
        segmentedControl.selectedSegmentIndex = selectedSegment
    }
    
    @objc private func segmentedControlValueChanged(_ segmentControl: UISegmentedControl) {
        segmentedControlValueChanged?(segmentControl.selectedSegmentIndex)
    }
}


