//
//  UIImageView+Extension.swift
//  FetchRewards-iOS-Coding-Challenge
//
//  Created by Ryan Nguyen on 4/26/22.
//

import Foundation
import UIKit

/// Image Cache property
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    @discardableResult
    ///
    func loadImageFromURL(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data:data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        task.resume()
        return task
    }
}
