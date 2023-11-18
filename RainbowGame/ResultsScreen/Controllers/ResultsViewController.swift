//
//  ResultsViewController.swift
//  RainbowGame
//
//  Created by Danila Okuneu on 13.11.23.
//

    import UIKit
    
    class ResultsViewController: RainbowViewController, UITableViewDataSource, UITableViewDelegate {
        // MARK: - Declaration
        
        private let storage: ResultsStorage = StorageService()
        private lazy var results = storage.results
        
        private let stackView: UIStackView = {
           let stackView = UIStackView()
            stackView.alpha = 0
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
            label.font = .boldSystemFont(ofSize: 25)
            label.textColor = Colors.mainText
            label.textAlignment = .center
            label.numberOfLines = 2
            label.alpha = 0.0
            label.text = """
                      Пока что здесь пусто
                      :)
                      """
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        override func viewDidLoad() {
            self.title = "Статистика"
            super.viewDidLoad()
            view.backgroundColor = Colors.background
            orderNumerate()
            setupTableView()
            setupViews()
            setupConstraints()
            updateUI()
            
    
            clearButton.addTarget(self, action: #selector(clearResults), for: .touchUpInside)
    
        }
        // MARK: - Setups
        
        private func setupViews() {
            
            
            view.addSubview(stackView)
            view.addSubview(emptyTableLabel)
            stackView.addSubview(tableView)
        
            stackView.addSubview(clearButton)
            
            
        }
        
        
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                
                tableView.topAnchor.constraint(equalTo: stackView.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
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
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(ResultCell.self, forCellReuseIdentifier: "resultCell")
        }
        
        
        // Удалить, когда реализуем механизм сохранения данных
       

        @objc private func clearResults() {
            storage.clearResults()
            results = storage.results
            updateUI()
            
        }
        
        private func updateUI() {
            UIView.animate(withDuration: 0.2) {
                self.stackView.alpha = self.results.isEmpty ? 0 : 1
                self.emptyTableLabel.alpha = self.results.isEmpty ? 1 : 0
            }
        }
        
        private func orderNumerate() {
            if !results.isEmpty {
                var number = results.count
                for index in 0...results.count-1 {
                    results[index].orderNumber = number
                    number -= 1
                }
            }
        }
      
        
        // MARK: - TableView Data Surce
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return results.count
        }
        
       
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
            let result = results[indexPath.row]
            cell.configure(with: result)
            cell.backgroundColor = UIColor().getLightBlueColor()
            return cell
        }
        
        
    }

