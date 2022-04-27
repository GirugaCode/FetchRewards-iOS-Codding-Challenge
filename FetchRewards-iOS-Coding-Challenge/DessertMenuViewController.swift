//
//  DessertMenuViewController.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/18/22.
//

import UIKit

class DessertMenuViewController: UIViewController {
    
    //MARK: - PROPERTIES
    
    /// Dessert Menu Data
    var dessertItems: [Dessert] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - UI COMPONENTS
    /// Table view property for the view
    private var tableView: UITableView!
    
    /// Constant value for each cell height
    private let cellRowHeight: CGFloat = 200
    private let dessertCellId = "DessertCellId"
    
    /// Activity Indicator to show when fetching data
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDessertsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureTableView()
        configureAutoLayout()
        configureActivityIndicator()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    
    /// Network Request to fetch all Desserts from API
    private func fetchDessertsData() {
        // Start activity indicator
        activityIndicator.startAnimating()
        NetworkService.request(endpoint: DessertEndpoint.getDessertResults(searchParam: "", value: "")) { (result: Result<DessertModels, Error>) in
            switch result {
            case .success(let response):
                // Populate dessertItems with network response
                self.dessertItems = response.meals
                DispatchQueue.main.async {
                    // Stop activity indicator
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print("Error:", error)
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    /// Configures properties of Navigation Bar
    private func configureNavigationBar() {
        navigationItem.title = "Dessert Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    
    /// Configures the activity indicator for the view
    private func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

/// Table View Delegate and Data Source Protocols
extension DessertMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dessertCellId, for: indexPath) as? DessertCell else { return UITableViewCell() }
        cell.configureCell(dessertItem: dessertItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DessertDetailViewController()
        controller.dessertID = dessertItems[indexPath.row].idMeal
        controller.dessertTitle = dessertItems[indexPath.row].strMeal
        controller.imageURL = dessertItems[indexPath.row].strMealThumb
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
