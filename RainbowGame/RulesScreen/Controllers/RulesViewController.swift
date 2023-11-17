//
//  RulesViewController.swift
//  RainbowGame
//
//  Created by Александра Савчук on 12.11.2023.
//

import UIKit
import SnapKit
class  RulesViewController: RainbowViewController {
    //MARK: - UI elements
    
    let rulesView = UIView()
    
    let titleLabel = UILabel.makeLabel(text: "ПРАВИЛА ИГРЫ", font: UIFont.systemFont(ofSize: 30.0, weight: .bold))
    
   let topMainLabel = UILabel.makeLabel(text: "На экране в случайном месте появляется слово, обозначающее цвет, например: написано «синий»:", font: UIFont.systemFont(ofSize: 18.0, weight: .regular), textAlignment: .natural, numberOfLines: 0)
  
    let aboveleftExampleLabel = UILabel.makeLabel(text: "подложка выключена", font: UIFont.systemFont(ofSize: 13.0, weight: .regular))
    
    let aboveRightExampleLabel = UILabel.makeLabel(text: "подложка включена", font: UIFont.systemFont(ofSize: 13.0, weight: .regular))

    let RightExampleButton = CustomButton(customTitle: "Синий", customBackgroundColor: UIColor(red: 0/255, green: 181/255, blue: 101/255, alpha: 1), customShadowColor: UIColor.black.cgColor)

    let leftExampleButton = CustomButton(customTitle: "Синий", customBackgroundColor: .clear, customTitleColor: UIColor(red: 0/255, green: 181/255, blue: 101/255, alpha: 1), customShadowColor: UIColor.clear.cgColor)
 
    let bottomMainLabel = UILabel.makeLabel(text: "Нужно произнести вслух цвет слова (если опция «подложка для букв» выключена) или цвет фона, на котором написано слово (если опция «подложка для букв» включена): говорим «зеленый». \n В игре можно изменять скорость от 1x до 5x. А так же длительность игры.", font: UIFont.systemFont(ofSize: 18.0, weight: .regular), textAlignment: .natural, numberOfLines: 0)

    //MARK: - ViewController Life
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Помощь"
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
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
            make.bottom.equalTo(bottomMainLabel).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(20)
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
