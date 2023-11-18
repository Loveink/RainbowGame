//
//  MainViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit

class MainViewController: UIViewController {
	
	/// three main buttons:
	var newGameButton = CustomButton(customTitle: "НОВАЯ ИГРА",
                                     customBackgroundColor: Colors.Interface.red,
                                     customTitleColor: Colors.Interface.darkRed, 
                                     customShadowColor: Colors.Interface.darkRed.cgColor)
	
	var continueButton = CustomButton(customTitle: "ПРОДОЛЖИТЬ",
                                      customBackgroundColor: Colors.Interface.yellow,
                                      customTitleColor: Colors.Interface.darkYellow,
                                      customShadowColor: Colors.Interface.darkYellow.cgColor)

	var statisticsButton = CustomButton(customTitle: "СТАТИСТИКА",
                                        customBackgroundColor: Colors.Interface.green,
                                        customTitleColor: Colors.Interface.darkGreen,
										customShadowColor: Colors.Interface.darkGreen.cgColor)
	
	/// two buttons for Settings and Rules
	var rulesButton = CustomRoundButton(imageName: "questionmark.circle")
	var settingsButton = CustomRoundButton(imageName: "gearshape.fill")
	
	/// image & title 
	private let rainbowImage: UIImageView = {
		let image = UIImageView()
		image.image = UIImage(named: "rainbow.png")
		image.translatesAutoresizingMaskIntoConstraints = false 
		image.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
		return image
	}()
	
	private let nameGame: UILabel = {
		let label = UILabel()
		label.text = "Радуга"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 28.0, weight: .medium)
		label.textColor = UIColor(red: 137/255, green: 68/255, blue: 171/255, alpha: 1.0)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	//MARK: - adding elements to our view
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = Colors.Interface.background

		addViews()
		addActions()
		setupViews()		
        
        settingsButton.tintColor = Colors.Interface.blueText
        rulesButton.tintColor = Colors.Interface.blueText
	}
    
    
	
	func addViews() {
		view.addSubview(newGameButton)
		view.addSubview(continueButton)
		view.addSubview(statisticsButton)
		view.addSubview(settingsButton)
		view.addSubview(rulesButton)
		view.addSubview(rainbowImage)
		view.addSubview(nameGame)
	}
	
	func addActions() {
		newGameButton.addTarget(self, action: #selector(self.addTapNewGame), for: .touchUpInside)
		continueButton.addTarget(self, action: #selector(self.addTapContinue), for: .touchUpInside)
		statisticsButton.addTarget(self, action: #selector(self.addTapStatistics), for: .touchUpInside)
		settingsButton.addTarget(self, action: #selector(self.addTapSettings), for: .touchUpInside)
		rulesButton.addTarget(self, action: #selector(self.addTapRules), for: .touchUpInside)
	}
	
	//MARK: - button actions
	@objc private func addTapNewGame() {
		print("Button tapped")
		let gameVC = GameScreen().build()
		navigationController?.pushViewController(gameVC, animated: true)
	}

	@objc private func addTapContinue() {
		print("Button tapped")
		let gameVC = GameScreen().build()
		navigationController?.pushViewController(gameVC, animated: true)
	}
	
	@objc private func addTapStatistics() {
		print("Button tapped")
		let resultsVC = ResultsViewController()
		navigationController?.pushViewController(resultsVC, animated: true)
	}
	
	@objc private func addTapSettings() {
		let settingsVC = SettingsViewController()
		navigationController?.pushViewController(settingsVC, animated: true)
	}
	
	@objc private func addTapRules() {
		let rulesVC = RulesViewController()
		navigationController?.pushViewController(rulesVC, animated: true)
	}
	
	//MARK: - size and positions elements
	func setupViews() {
		
		self.newGameButton.translatesAutoresizingMaskIntoConstraints = false
		//self.continueButton.translatesAutoresizingMaskIntoConstraints = false
		self.statisticsButton.translatesAutoresizingMaskIntoConstraints = false
		self.settingsButton.translatesAutoresizingMaskIntoConstraints = false
		self.rulesButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			newGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
			newGameButton.widthAnchor.constraint(equalToConstant: 274),
			newGameButton.heightAnchor.constraint(equalToConstant: 83),
			
			continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 140),
			continueButton.widthAnchor.constraint(equalToConstant: 274),
			continueButton.heightAnchor.constraint(equalToConstant: 83),
			
			statisticsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			statisticsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 240),
			statisticsButton.widthAnchor.constraint(equalToConstant: 274),
			statisticsButton.heightAnchor.constraint(equalToConstant: 83),
			
			settingsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			settingsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
			settingsButton.widthAnchor.constraint(equalToConstant: 60),
			settingsButton.heightAnchor.constraint(equalToConstant: 60),
			
			rulesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			rulesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
			rulesButton.widthAnchor.constraint(equalToConstant: 60),
			rulesButton.heightAnchor.constraint(equalToConstant: 60),
			
			rainbowImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rainbowImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
			
			nameGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			nameGame.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -80)
		])
	}
	
}
