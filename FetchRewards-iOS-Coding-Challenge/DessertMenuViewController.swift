//
//  DessertMenuViewController.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/18/22.
//

import UIKit

class DessertMenuViewController: UIViewController {
    
    //MARK: - PROPERTIES
    
    /// Table view property for the view
    private var tableView: UITableView!
    
    /// Constant value for each cell height
    private let cellRowHeight: CGFloat = 140
    private let dessertCellId = "DessertCellId"
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.04705882353, blue: 0.2196078431, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureTableView()
        configureAutoLayout()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    
    /// Configures properties of Navigation Bar
    private func configureNavigationBar() {
        navigationItem.title = "Dessert Menu"
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.04705882353, blue: 0.2196078431, alpha: 1)
            appearance.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)]
            appearance.largeTitleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)]

            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1843137255, green: 0.04705882353, blue: 0.2196078431, alpha: 1)
            navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    /// Configures properties of TableView Bar
    private func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = cellRowHeight
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(DessertCell.self, forCellReuseIdentifier: dessertCellId)
    }
    
    /// Configures Autolayout of the view
    private func configureAutoLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

/// TableView Delegate and Data Source Protocols
extension DessertMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dessertCellId, for: indexPath) as? DessertCell else { return UITableViewCell() }
        
        return cell
    }
    
}
