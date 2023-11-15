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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.arrowLeft, style: .plain, target: self, action: #selector(didTapBackBarButtonItem(_:)))
    }
    
    @objc
    func didTapBackBarButtonItem(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}
