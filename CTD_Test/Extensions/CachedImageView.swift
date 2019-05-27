//
//  CachedImageView.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CacheableImageView: UIImageView {
    
    private var imageUrlString: String?
    
    func loadFromString(urlString: String) {
        let url = URL(string: urlString)
        
        imageUrlString = urlString
        image = UIImage(named: "placeholder")
        
        //Cache already has Image for provided URL
        
        if let cached = imageCache.object(forKey: urlString as NSString) {
            self.image = cached
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            guard error == nil else {
                self.retryAfterTimeout()
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data!) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = image
                }
                
                imageCache.setObject(image, forKey: urlString as NSString)
            }
        }).resume()
    }
    
    private func retryAfterTimeout() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.loadFromString(urlString: self.imageUrlString!)
        }
    }
}

