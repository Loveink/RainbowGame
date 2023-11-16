//
//  UILabel+Extension.swift
//  RainbowGame
//
//  Created by Александра Савчук on 16.11.2023.
//

import UIKit

extension UILabel {

  static func makeLabel(text: String, font: UIFont?, textColor: UIColor = .black, textAlignment: NSTextAlignment = .center, numberOfLines: Int = 1) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    label.textAlignment = textAlignment
    label.numberOfLines = numberOfLines
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
}
