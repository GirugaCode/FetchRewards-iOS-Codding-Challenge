//
//  Endpoint.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/25/22.
//

import Foundation

protocol Endpoint {
    /// HTTP or HTTPS
    var scheme: String { get }
    
    /// Base URL of request
    var baseURL: String { get }
    
    /// URL path ex. /services/rest
    var path: String { get }
    
    /// Parameters for URL, API key
    var parameters: [URLQueryItem] { get }
    
    /// ex. "GET"
    var method: String { get }
}
