//
//  ImageCache.swift
//  Arch
//
//  Created by Munendra Singh on 18/12/20.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

/// use this class to download and cache image
class ImageLoader: UIImageView {
    

    var imageURL: URL?

    let activityIndicator = UIActivityIndicatorView()
    
    /// loadImageWithUrl method will download image and save it to cache
    /// - Parameters:
    ///   - url: imahe url
    ///   - placeHolderImage: place holder image
    func loadImageWithUrl(url: URL, placeHolderImage: UIImage?) {

        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageURL = url
        image = nil
        
        activityIndicator.startAnimating()

        // retrieves image if already available in cache
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {

            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async(execute: {
                    self.activityIndicator.stopAnimating()
                    self.image = placeHolderImage
                    return
                })
            }
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                } else {
                    self.image = placeHolderImage
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}
