//
//  RulesViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit
import SnapKit
class  RulesViewController: UIViewController {
    //MARK: - UI elements
    
    let rulesView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛА ИГРЫ"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let topMainLabel: UILabel = {
        let label = UILabel()
        label.text = "На экране в случайном месте появляется слово, обозначающее цвет, например: написано «синий»:"
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    let aboveleftExampleLabel: UILabel = {
        let label = UILabel()
        label.text = "подложка выключена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .black
        return label
    }()
    let aboveRightExampleLabel: UILabel = {
        let label = UILabel()
        label.text = "подложка включена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.textColor = .black
        return label
    }()
    let RightExampleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Синий", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 32/255, green: 203/255, blue: 61/255, alpha: 1)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.layer.shadowOpacity = 0.25
        return button
    }()
    let leftExampleButton: UIButton = {
        let button = UIButton()
        button.setTitle("Синий", for: .normal)
        button.setTitleColor(UIColor(red: 32/255, green: 203/255, blue: 61/255, alpha: 1), for: .normal)
        button.backgroundColor = .clear
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .init(width: 0, height: 4)
        button.layer.shadowOpacity = 0.25
        return button
    }()
    
    let bottomMainLabel: UILabel = {
        let label = UILabel()
        label.text = "Нужно произнести вслух цвет слова (если опция «подложка для букв» выключена) или цвет фона, на котором написано слово (если опция «подложка для букв» включена): говорим «зеленый». \n В игре можно изменять скорость от 1x до 5x. А так же длительность игры."
        label.textAlignment = .natural
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
        
    
    
    //MARK: - ViewController Life
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        setUpUI()
    }
    //MARK: - Add view
    func addView() {
        view.addSubview(rulesView)
        rulesView.addSubview(titleLabel)
        rulesView.addSubview(topMainLabel)
        rulesView.addSubview(aboveleftExampleLabel)
        rulesView.addSubview(aboveRightExampleLabel)
        rulesView.addSubview(RightExampleButton)
        rulesView.addSubview(leftExampleButton)
        rulesView.addSubview(bottomMainLabel)
    }
    //MARK: - UI setting
    func setUpUI() {
        
        view.backgroundColor = .white
        
        // setting rules view
        rulesView.backgroundColor = UIColor(red: 236/255, green: 231/255, blue: 237/255, alpha: 1)
        rulesView.layer.cornerRadius = 10
        
        
        rulesView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(40)
            //make.top.equalToSuperview().inset(160)
            make.centerY.equalToSuperview()
            make.bottom.equalTo(bottomMainLabel).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(20)
        }
        
        topMainLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        let attributedString = NSMutableAttributedString(string: topMainLabel.text!)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 83, length: 8))
        topMainLabel.attributedText = attributedString
        
        aboveleftExampleLabel.snp.makeConstraints { make in
            make.top.equalTo(topMainLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
        aboveRightExampleLabel.snp.makeConstraints { make in
            make.top.equalTo(topMainLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
                }
        RightExampleButton.snp.makeConstraints { make in
            make.top.equalTo(aboveRightExampleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(aboveRightExampleLabel)
            make.height.equalTo(25)
           }
        leftExampleButton.snp.makeConstraints { make in
            make.top.equalTo(aboveleftExampleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(aboveleftExampleLabel)
            make.height.equalTo(25)
               }
        bottomMainLabel.snp.makeConstraints { make in
            make.top.equalTo(leftExampleButton.snp.bottom).offset(15)
            make.leading.trailing.equalTo(topMainLabel)
        }
        let attributedString2 = NSMutableAttributedString(string: bottomMainLabel.text!)
        attributedString2.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 160, length: 18))
        bottomMainLabel.attributedText = attributedString2

    }
}
