//
//  ColorsExtension.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 15.11.23.
//

import UIKit

extension UIView {
    
    func dropShadow() {
       self.layer.masksToBounds = false
       self.layer.shadowColor = UIColor.black.cgColor
       self.layer.shadowOpacity = 0.3
       self.layer.shadowOffset = CGSize(width: 0, height: 2)
       self.layer.shadowRadius = 3
       self.translatesAutoresizingMaskIntoConstraints  = false
    }
}
