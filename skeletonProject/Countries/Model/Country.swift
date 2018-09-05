//
//  Countries.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import Foundation
struct Country: Decodable {
    let id:Int
    let image:String?
    let name:String?
    let created_at:String?
    let updated_at:String?
    static func fetchCountries(completionHandler:@escaping ([Country],Bool) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/country")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            print("inside closure")
            var countries = [Country]()
            var loadedData:Bool = true
            if error != nil
            {
                loadedData = false
                // customErrorMessage = "Something Went Wrong! Make sure you are connected to the internet!"
            }
            else
            {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    do
                    {
                        let allCountries = try JSONDecoder().decode([Country].self,from: data!)
                        countries = allCountries
                    }
                    catch
                    {
                     loadedData = false
                    }
                }
                else
                {
                    loadedData = false
                }
            }
            DispatchQueue.main.async {
                completionHandler(countries,loadedData)
            }
            
            }.resume()
    }
}
