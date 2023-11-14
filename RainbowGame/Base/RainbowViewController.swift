//
//  ViewController.swift
//  RainbowGame
//
//  Created by Victor on 13.11.2023.
//

import UIKit

class RainbowViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
    }
    
    @objc
    func didTapBackBarButtonItem(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
