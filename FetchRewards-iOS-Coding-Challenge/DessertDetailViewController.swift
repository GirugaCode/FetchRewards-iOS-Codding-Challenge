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
    var dessertDetails: [DessertDetails] = []
    
    //MARK: - UI COMPONENTS
    
    
    //MARK: - VIEW CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        fetchDessertDetails()
    }
    
    //MARK: - PRIVATE FUNCTIONS
    /// Network Request to fetch Desserts Details from API
    private func fetchDessertDetails() {
        NetworkService.request(endpoint: DessertEndpoint.getDessertDetails(searchParam: "", value: dessertID)) { (result: Result<DessertDetails, Error>) in
            switch result {
            case .success(let response):
                print("Response:", response)
            case .failure(let error):
                print("Error:", error)
            }
        }

    }
}
