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
    
    private lazy var speedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.tintColor = .white
        button.layer.cornerRadius = Layout.speedViewSize.width / 2
        button.addTarget(self, action: #selector(didTapSpeed), for: .touchUpInside)
        return button
    }()
    
    private var speedButtonHandler: (() -> Void)?
    private var previousNavBarApperance: UINavigationBarAppearance?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        previousNavBarApperance = navigationController?.navigationBar.standardAppearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            previousNavBarApperance = appearance
            appearance.backgroundColor = Colors.Background.lvl1
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
        
        presenter.activate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let previousNavBarApperance else {
            return
        }
        navigationController?.navigationBar.standardAppearance = previousNavBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = previousNavBarApperance
    }

    func updateTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func updateWith(_ viewModel: GameScreen.ViewModel) {
        
        view.backgroundColor = viewModel.backgroundColor
        
        if let speed = viewModel.speed {
            speedButton.setTitle(speed, for: .normal)
            speedButton.isHidden = false
        } else {
            speedButton.isHidden = true
        }
        speedButtonHandler = viewModel.speedClosure
        
        if let color = viewModel.color {
            colorView.update(
                .init(
                    text: color.text,
                    textColor: color.textColor,
                    fontSize: color.fontSize,
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
    
    func updateGameState(_ state: GameScreen.GameState) {
        configureRightButton(state)
    }
    
    func updateSpeed(_ value: String) {
        speedButton.setTitle(value, for: .normal)
    }
    
    private func updateColorViewPosition(_ position: GameWordPosition) {
        switch position {
        case .middle:
            colorView.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        case .random:
            
            view.setNeedsLayout()
            view.layoutIfNeeded()
            
            let lowerY = UIApplication.safeAreaInsets.top + (navigationController?.navigationBar.frame.height ?? .zero) + 10
            let upperY = view.bounds.height - colorView.bounds.height - UIApplication.safeAreaInsets.top - UIApplication.safeAreaInsets.bottom - 10
            let lowerX = UIApplication.safeAreaInsets.left + 10
            let upperX = view.bounds.width - colorView.bounds.width - UIApplication.safeAreaInsets.left - UIApplication.safeAreaInsets.right - 10
            let y = CGFloat.random(in: (lowerY..<upperY))
            var x = CGFloat.random(in: (lowerX..<upperX))
            
            if !speedButton.isHidden {
                if y + colorView.bounds.height > speedButton.frame.minY && x + Layout.colorViewSize.width > speedButton.frame.minX {
                    x = speedButton.frame.minX - colorView.bounds.width - Layout.speedViewInsets.right
                }
            }
            
            colorView.snp.remakeConstraints {
                $0.size.equalTo(Layout.colorViewSize).priority(900)
                $0.leading.equalTo(x)
                $0.top.equalTo(y)
            }
        }
    }
    
    private func configure() {
        view.backgroundColor = Colors.Interface.background
        
        view.addSubview(speedButton)
        speedButton.snp.makeConstraints {
            $0.size.equalTo(Layout.speedViewSize)
            $0.trailing.equalToSuperview().inset(Layout.speedViewInsets.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(Layout.speedViewInsets.bottom)
        }
        
        colorView.snp.makeConstraints {
            $0.size.equalTo(Layout.colorViewSize).priority(900)
        }
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func configureRightButton(_ state: GameScreen.GameState) {
        switch state {
        case .plaing:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: Images.pause,
                style: .plain,
                target: self,
                action: #selector(didTapPause)
            )
        case .paused:
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: Images.play,
                style: .plain,
                target: self,
                action: #selector(didTapPlay)
            )
        }
    }
    
    @objc
    private func didTapPause() {
        presenter.pause()
    }
    
    @objc
    private func didTapPlay() {
        presenter.play()
    }
    
    @objc
    private func didTapSpeed() {
        speedButtonHandler?()
    }
}
