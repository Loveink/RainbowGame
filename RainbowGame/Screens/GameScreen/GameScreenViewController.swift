//
//  GameScreenViewController.swift
//  RainbowGame
//
//  Created by Viktor on 12.11.2023.
//

import UIKit

final class GameScreenViewController: RainbowViewController, GameScreenInput {
    
    enum Layout {
        static let colorViewSize: CGSize = .init(width: 205, height: 40)
        static let speedViewSize: CGSize = .init(width: 75, height: 75)
        static let speedViewInsets: UIEdgeInsets = .init(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    var presenter: GameScreenOutput!
    private let colorView: ColorView = {
        let view = ColorView()
        return view
    }()
    
    private let speedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Layout.speedViewSize.width / 2
        view.backgroundColor = Colors.Cards.red
        return view
    }()
    
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.activate()
    }

    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func updateWith(_ viewModel: GameScreen.ViewModel) {
        if let speed = viewModel.speed {
            speedLabel.text = speed
            speedView.isHidden = false
        } else {
            speedView.isHidden = true
        }
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
            updateColorViewPosition(viewModel.wordPosition)
        } else {
            colorView.removeFromSuperview()
        }
    }
    
    private func updateColorViewPosition(_ position: GameWordPosition) {
        switch position {
        case .middle:
            colorView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .random:
            let lowerY = UIApplication.safeAreaInsets.top + (navigationController?.navigationBar.frame.height ?? .zero)
            let upperY = view.bounds.height - Layout.colorViewSize.height - UIApplication.safeAreaInsets.top - UIApplication.safeAreaInsets.bottom
            let upperX = view.bounds.width - Layout.colorViewSize.width - UIApplication.safeAreaInsets.left - UIApplication.safeAreaInsets.right
            let y = CGFloat.random(in: (lowerY..<upperY))
            var x = CGFloat.random(in: (UIApplication.safeAreaInsets.left..<upperX))
            
            if !speedView.isHidden {
                if y + Layout.colorViewSize.height > speedView.frame.minY && x + Layout.colorViewSize.width > speedView.frame.minX {
                    x = speedView.frame.minX - Layout.colorViewSize.width - Layout.speedViewInsets.right
                }
            }
            
            colorView.snp.remakeConstraints {
                $0.size.equalTo(Layout.colorViewSize)
                $0.leading.equalTo(x)
                $0.top.equalTo(y)
            }
        }
    }
    
    private func configure() {
        view.backgroundColor = Colors.Background.lvl1
        
        view.addSubview(speedView)
        speedView.addSubview(speedLabel)
        speedLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        speedView.snp.makeConstraints {
            $0.size.equalTo(Layout.speedViewSize)
            $0.trailing.equalToSuperview().inset(Layout.speedViewInsets.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Layout.speedViewInsets.bottom)
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Images.pause, style: .plain, target: self, action: #selector(didTapPause))
    }
    
    @objc
    private func didTapPause() {
        presenter.pause()
    }
}
