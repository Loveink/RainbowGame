//
//  ResultCell.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

import UIKit

class ResultCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()

    private let orderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Colors.Interface.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let speedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Colors.Interface.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = Colors.Interface.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = Colors.Interface.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(orderLabel)
        containerView.addSubview(speedLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(scoreLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            orderLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            orderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),

            speedLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            speedLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            timeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            scoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            scoreLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with result: GameResult) {
        
        if result.score == 0 {
            scoreLabel.isHidden = true
        } else if result.score == result.totalColors && result.totalColors != 0 {
            containerView.backgroundColor = Colors.Interface.yellow
            scoreLabel.textColor = Colors.Interface.darkYellow
            timeLabel.textColor = Colors.Interface.darkYellow
            orderLabel.textColor = Colors.Interface.darkYellow
            speedLabel.textColor = Colors.Interface.darkYellow
        }
        
            speedLabel.text = "Скорость: \(result.speed)x"
            scoreLabel.text = "\(result.score)/\(result.totalColors)"
            timeLabel.text = String(result.time)
            orderLabel.text = "Игра №\(result.orderNumber)"
        
        
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()

            containerView.backgroundColor = .white
        scoreLabel.isHidden = false
            scoreLabel.textColor = Colors.Interface.gray
            timeLabel.textColor = Colors.Interface.gray
            orderLabel.textColor = Colors.Interface.gray
            speedLabel.textColor = Colors.Interface.gray
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
