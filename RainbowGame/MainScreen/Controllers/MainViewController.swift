//
//  MainViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit

class MainViewController: RainbowViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.pushViewController(GameScreen().build(), animated: true)
    }
}

