//
//  DessertModels.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import Foundation

// MARK: - DessertModels
struct DessertModels: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}

