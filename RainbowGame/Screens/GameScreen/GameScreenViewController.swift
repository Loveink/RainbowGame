//
//  GameScreenViewController.swift
//  RainbowGame
//
//  Created by Viktor on 12.11.2023.
//

import UIKit

final class GameScreenViewController: UIViewController, GameScreenInput {
    
    enum Layout {
        static let colorViewSize: CGSize = .init(width: 205, height: 40)
    }
    
    var presenter: GameScreenOutput!
    private let colorView: ColorView = {
        let view = ColorView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        presenter.activate()
    }

    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func updateWith(_ viewModel: GameScreen.ViewModel) {
        if let color = viewModel.color {
            colorView.update(
                .init(
                    text: color.text,
                    textColor: color.textColor,
                    frameColor: color.frame?.color,
                    didSelectHandler: color.didSelectHandler
                )
            )
            if colorView.superview == nil {
                view.addSubview(colorView)
            }
            updateColorViewPosition()
        } else {
            colorView.removeFromSuperview()
        }
    }
    
    private func updateColorViewPosition() {
        let upperY = view.bounds.height - Layout.colorViewSize.height - UIApplication.safeAreaInsets.top - UIApplication.safeAreaInsets.bottom
        let upperX = view.bounds.width - Layout.colorViewSize.width - UIApplication.safeAreaInsets.left - UIApplication.safeAreaInsets.right
        let y = CGFloat.random(in: (UIApplication.safeAreaInsets.top..<upperY))
        let x = CGFloat.random(in: (UIApplication.safeAreaInsets.left..<upperX))
        
        colorView.snp.remakeConstraints {
            $0.size.equalTo(Layout.colorViewSize)
            $0.leading.equalTo(x)
            $0.top.equalTo(y)
        }
    }
    
    private func configure() {
        view.backgroundColor = Colors.Background.lvl1
    }
}
