//
//  DessertEndpoint.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import Foundation

enum DessertEndpoint: Endpoint {
    
    /// Case statment to construct parameters for Dessert Items
    case getDessertResults(searchParam: String, value: String)
    
    /// Case statment to construct parameters for Dessert Details
    case getDessertDetails(searchParam: String, value: String)
    
    /// HTTP or HTTPS
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    /// Base constructor for URL
    var baseURL: String {
        switch self {
        default:
            return "themealdb.com"
        }
    }
    
    /// Path constructor for URL
    var path: String {
        switch self {
        case .getDessertResults:
            return "/api/json/v1/1/filter.php"
            
        case .getDessertDetails:
            return "/api/json/v1/1/lookup.php"
        }
    }
    
    /// Parameter constructor for URL
    var parameters: [URLQueryItem] {
        
        switch self {
        case .getDessertResults(_, _):
            return [URLQueryItem (name: "c", value: "Dessert")]
        case .getDessertDetails(_, let page):
            return [URLQueryItem(name: "i", value: page)]
        }
    }
    
    /// Handles the HTTP methods of the URL
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
