//
//  DessertDetailViewController.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import UIKit

class DessertDetailViewController: UIViewController {
    //MARK: - PROPERTIES
    var dessertID = ""
    var dessertTitle = ""
    var imageURL = ""
    
    var dessertDetails: [DessertInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.dessertInstructions.text = self.dessertDetails.first?.instructions
            }
        }
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    //MARK: - UI COMPONENTS
    private lazy var dessertDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dessertDetailImageView,dessertInstructions,dessertIngredients])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dessertDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 2
        iv.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.6509803922, blue: 0.09803921569, alpha: 1)
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let dessertInstructions: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let dessertIngredients: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDessertDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .brown
        configureNavigationBar()
        configureScrollView()
        configureDessertDetails()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    /// Network Request to fetch Desserts Details from API
    private func fetchDessertDetails() {
        NetworkService.request(endpoint: DessertEndpoint.getDessertDetails(searchParam: "", value: dessertID)) { (result: Result<DessertDetails, Error>) in
            switch result {
            case .success(let response):
                print("Response:", response)
                self.dessertDetails = response.meals
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    /// Configures properties of Navigation Bar
    private func configureNavigationBar() {
        navigationItem.title = dessertTitle
        
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
    
    /// Configures ScrollView into view
    private func configureScrollView() {
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            contentView.translatesAutoresizingMaskIntoConstraints = false
        
            view.addSubview(scrollView)
            scrollView.addSubview(contentView)
        
            NSLayoutConstraint.activate([
                scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            ])
        }

    private func configureDessertDetails() {
        contentView.addSubview(dessertDetailStackView)
        
        dessertDetailImageView.loadImageFromURL(urlString: imageURL, placeholder: UIImage(named: "FetchRewardsPlaceholder"))
        
        NSLayoutConstraint.activate([
            dessertDetailStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dessertDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dessertDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dessertDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dessertDetailImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
