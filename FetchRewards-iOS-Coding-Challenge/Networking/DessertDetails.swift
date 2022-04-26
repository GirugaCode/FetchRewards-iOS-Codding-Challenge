//
//  DessertDetails.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import Foundation

//MARK: - DessertDetails
struct DessertDetails: Codable {
    let meals: [DessertInfo]
}

//MARK: - DessertInfo
struct DessertInfo: Codable {
    let name: String
    let imageUrlString: String
    let ingredients: [Ingredient]
    let instructions: String
}

// Filters through Dessert details and retrieves only vaild ingredients and measurements
extension DessertInfo {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dessertDictionary = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients: [Ingredient] = []
        
        while let ingredient = dessertDictionary["strIngredient\(index)"] as? String,
                let measure = dessertDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        
        self.ingredients = ingredients
        name = dessertDictionary["strMeal"] as? String ?? ""
        imageUrlString = dessertDictionary["strMealThumb"] as? String ?? ""
        instructions = dessertDictionary["strInstructions"] as? String ?? ""
    }
}

//MARK: - Ingredient
struct Ingredient: Codable {
    let name: String
    let measure: String
}
