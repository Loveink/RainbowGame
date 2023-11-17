//
//  ResultsViewController.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

    import UIKit

    class ResultsViewController: RainbowViewController, UITableViewDataSource, UITableViewDelegate {
        // MARK: - Declaration
        private let gameResults = GameResults()
        
        private let stackView: UIStackView = {
           let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        private let tableView: UITableView = {
            let table = UITableView()
            table.backgroundColor = UIColor().getLightBlueColor()
            table.separatorStyle = .none
            table.allowsSelection = false
            table.allowsSelectionDuringEditing = false
            table.showsVerticalScrollIndicator = false
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
        
        private let clearButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Очистить Результаты", for: .normal)
            button.setTitleColor(UIColor(red: 152/255, green: 10/255, blue: 1/255, alpha: 1), for: .normal)
            button.backgroundColor = UIColor().getRedColor()
            button.titleLabel?.minimumScaleFactor = 0.5
            button.titleLabel?.adjustsFontSizeToFitWidth = true
            button.layer.cornerRadius = 25
            button.titleLabel?.font = .boldSystemFont(ofSize: 25)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            return button
        }()
        
        private let emptyTableLabel: UILabel = {
            let label = UILabel()
            label.isHidden = true
            label.font = .boldSystemFont(ofSize: 25)
            label.textColor = .black
            label.textAlignment = .center
            label.numberOfLines = 2
            label.text = """
                      Пока что здесь пусто
                      :)
                      """
            label.dropShadow()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func viewDidLoad() {
            self.title = "Статистика"
            super.viewDidLoad()
            view.backgroundColor = UIColor().getLightBlueColor()
            setupTableView()
            setupViews()
            setupConstraints()
            loadResults()
            clearButton.addTarget(self, action: #selector(clearResults), for: .touchUpInside)
        }
        // MARK: - Setups

        private func setupViews() {
            view.addSubview(stackView)
            stackView.addSubview(tableView)
            stackView.addSubview(clearButton)
            view.addSubview(emptyTableLabel)
            
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -25),
                tableView.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -10),
                
                
                clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                clearButton.heightAnchor.constraint(equalToConstant: 65),
                clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
                clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
                
                clearButton.titleLabel!.leadingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: 10),
                clearButton.titleLabel!.trailingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: -10),
                
                emptyTableLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                emptyTableLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                ])
        }
        
        
        private func setupTableView() {
            view.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(ResultCell.self, forCellReuseIdentifier: "resultCell")
        }
        
        
        // Удалить, когда реализуем механизм сохранения данных
        private func loadResults() {
            
            gameResults.addResult(score: 5, totalWords: 5, time: 15.5, speed: 2)
            gameResults.addResult(score: 3, totalWords: 10, time: 15.5, speed: 2)
            gameResults.addResult(score: 7, totalWords: 7, time: 13.5, speed: 2)
            gameResults.addResult(score: 2, totalWords: 10, time: 2, speed: 2)
            
            gameResults.addResult(score: 5, totalWords: 5, time: 15.5, speed: 2)
            gameResults.addResult(score: 3, totalWords: 10, time: 15.5, speed: 2)
            gameResults.addResult(score: 7, totalWords: 10, time: 13.5, speed: 2)
            gameResults.addResult(score: 2, totalWords: 10, time: 2, speed: 2)
            gameResults.addResult(score: 5, totalWords: 5, time: 15.5, speed: 2)
            gameResults.addResult(score: 3, totalWords: 10, time: 15.5, speed: 2)
            gameResults.addResult(score: 7, totalWords: 10, time: 13.5, speed: 2)
            gameResults.addResult(score: 2, totalWords: 10, time: 2, speed: 2)
            gameResults.addResult(score: 5, totalWords: 5, time: 15.5, speed: 2)
            gameResults.addResult(score: 3, totalWords: 10, time: 15.5, speed: 2)
            gameResults.addResult(score: 7, totalWords: 10, time: 13.5, speed: 2)
            gameResults.addResult(score: 2, totalWords: 10, time: 2, speed: 2)
        }
        
       
    
        
        
        @objc private func clearResults() {
            gameResults.clearResults()
            tableView.reloadData()
        }
        // MARK: - TableView Data Surce
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return gameResults.getResults().count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
            let result = gameResults.getResults()[indexPath.row]
            cell.configure(with: result)
            cell.backgroundColor = UIColor().getLightBlueColor()
            return cell
        }
        
        
    }
