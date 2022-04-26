//
//  DessertEndpoint.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import Foundation

enum DessertEndpoint: Endpoint {
    
    case getDessertResults(searchParam: String, value: String)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "themealdb.com"
        }
    }
    
    var path: String {
        switch self {
        case .getDessertResults:
            return "/api/json/v1/1/filter.php"
        }
    }
    
    var parameters: [URLQueryItem] {
        
        switch self {
        case .getDessertResults(_, _) :
            return [URLQueryItem (name: "c", value: "Dessert")]
        }
    }
    
    /*
     Expected URL: https:www.themealdb.com/api/json/v1/1/filter.php?c=Dessert
     Result URL:   https:www.themealdb.com/api/json/v1/1/?dessert_menu=filter.php?c%3DDessert
                   https:www.themealdb.com/api/json/v1/1/?filter.php?c%3DDessert=Dessert
                   https:www.themealdb.com/api/json/v1/1/?filter.php?c=Dessert
                   https:www.themealdb.com/api/json/v1/1/filter.php%3Fc?=Dessert
                   https:www.themealdb.com/api/json/v1/1/filter.php??c=Dessert
     **/
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
}
