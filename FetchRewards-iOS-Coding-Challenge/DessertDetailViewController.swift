//
//  DessertDetailViewController.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import UIKit

class DessertDetailViewController: UIViewController {
    //MARK: - PROPERTIES
    
    /// Captures the dessertID passed from DessertMenuViewController
    var dessertID = ""
    
    /// Captures the dessertTitle passed from DessertMenuViewController
    var dessertTitle = ""
    
    /// Captures the imageURL passed from DessertMenuViewController
    var imageURL = ""
    
    /// Dessert Details of selected choice
    var dessertDetails: [DessertInfo] = [] {
        didSet {
            DispatchQueue.main.async {
                self.dessertInstructionsTextView.text = self.dessertDetails.first?.instructions
            }
        }
    }
    
    /// Dessert Ingredients of selected choice
    var dessertIngredients: [Ingredient] = []
    
    /// Dessert Ingredients and Measurements of selected choice
    var dessertIngredientsMeasurementsDetails = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.dessertIngredientsTextView.text = self.dessertIngredientsMeasurementsDetails.joined(separator: "\n")
            }
        }
    }

    //MARK: - UI COMPONENTS
    
    /// Scroll view of Dessert Details
    private let scrollView = UIScrollView()
    
    /// Content view for scrollView
    private let contentView = UIView()
    
    /// Stackview holding Dessert Detail UI elements
    private lazy var dessertDetailStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dessertDetailImageView,dessertIngredientsTextView,dessertInstructionsTextView])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    /// Image View of selected dessert
    private let dessertDetailImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    /// Text view of ingredients for selected dessert
    private let dessertIngredientsTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    /// Text view of instructions for selected dessert
    private let dessertInstructionsTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
        view.backgroundColor = .white
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
                // Populate dessertDetails
                self.dessertDetails = response.meals
                
                // Populate dessertIngredients
                self.dessertIngredients = response.meals.first!.ingredients
                
                // Add dessert ingredients into dessertIngredientsMeasurementsDetails array
                self.dessertIngredients.forEach { ingredientInstructions in
                    self.dessertIngredientsMeasurementsDetails.append(ingredientInstructions.name + " - " + ingredientInstructions.measure)
                }
                
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    /// Configures properties of Navigation Bar
    private func configureNavigationBar() {
        navigationItem.title = dessertTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = ""
        
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

    /// Configures the view of Dessert Details
    private func configureDessertDetails() {
        contentView.addSubview(dessertDetailStackView)
        
        dessertDetailImageView.loadImageFromURL(urlString: imageURL, placeholder: UIImage(named: "FetchRewardsPlaceholder"))
                
        NSLayoutConstraint.activate([
            dessertDetailStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dessertDetailStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dessertDetailStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dessertDetailStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dessertDetailImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
