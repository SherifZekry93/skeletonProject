//
//  ImageView.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//
import UIKit
import Alamofire
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
            image = imageFromCache
            return
        }
        Alamofire.request(url).response{
            response in
            if response.error != nil
            {
                return
            }
            guard let data = response.data else {return}
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                if self.imageUrlString == url
                {
                    imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                }
                self.image = imageToCache
                
            }
        }
    }
}
