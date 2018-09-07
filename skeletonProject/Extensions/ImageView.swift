//
//  ImageView.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
class CustomImageView: UIImageView
{
    var imageUrlString:URL?
    func downloadImage(from url: URL)
    {
        imageUrlString = url
        image = nil
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage
        {
            print("loading cached image")
            image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil
            {
                return
            }
            print("loading from server")
            DispatchQueue.main.async {
                if let imageData = data
                {
                    let imageToCache = UIImage(data: imageData)
                    if self.imageUrlString == url
                    {
                        imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                    }
                    self.image = imageToCache
                }
            }
            
            }.resume()
    }
}
