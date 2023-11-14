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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor                           = .white
        table.separatorStyle                            = .none
        table.allowsSelection                           = false
        table.allowsSelectionDuringEditing              = false
        table.showsVerticalScrollIndicator              = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Очистить Результаты", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor                              = .red
        button.layer.cornerRadius                           = 25
        button.titleLabel?.font                             = .boldSystemFont(ofSize: 25)
        button.translatesAutoresizingMaskIntoConstraints    = false
        button.layer.shadowColor                            = UIColor.black.cgColor
        button.layer.shadowOpacity                          = 0.3
        button.layer.shadowOffset                           = CGSizeZero
        button.layer.shadowRadius                           = 3
        return button
    }()
    
    private let bestResultLabel: UILabel = {
        let label = UILabel()
        label.font                                      = .boldSystemFont(ofSize: 20)
        label.textColor                                 = .black
        label.textAlignment                             = .left
        label.text                                      = "Лучший результат: типа время)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyTableLabel: UILabel = {
        let label = UILabel()
        label.isHidden                                   = true
        label.font                                      = .boldSystemFont(ofSize: 25)
        label.textColor                                 = .black
        label.textAlignment                             = .center
        label.numberOfLines                             = 2
        label.text                                      = """
                                                            Пока что здесь пусто
                                                            :)
                                                            """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Статистика"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.arrowLeft, style: .plain, target: self, action: #selector(didTapBackButton))
        setupTableView()
        setupStackView()
        updateUI()
    }
    
    
    
    
    
    // MARK: - Setups
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [tableView, bestResultLabel, clearButton, emptyTableLabel])
        stackView.axis                                      = .vertical
        stackView.spacing                                   = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(stackView)
        clearButton.heightAnchor.constraint(equalToConstant: 65).isActive = true
        clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        clearButton.addTarget(self, action: #selector(clearResults), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
  
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource        = self
        tableView.delegate          = self
        tableView.separatorStyle    = .none
        tableView.register(ResultCell.self, forCellReuseIdentifier: "resultCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateUI() {
        let hasResults              = !results.isEmpty
        tableView.isHidden          = !hasResults
        bestResultLabel.isHidden    = !hasResults
        clearButton.isHidden        = !hasResults
        emptyTableLabel.isHidden    = hasResults
        
        if hasResults {
            tableView.reloadData()
        }
    }
    
    @objc private func clearResults() {
        storage.clearResults()
        results = []
        updateUI()
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    // MARK: - TableView Data Surce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell    = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultCell
        let result  = results[indexPath.row]
        cell.configure(with: result)
        cell.backgroundColor = .white
    
        return cell
    }
    
    
}
