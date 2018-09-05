//
//  CountrySectionsModel.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
struct Category : Codable
{
    var id:Int?
    var country_id:Int?
    var name:String?
    var image:String?
    var created_at:String
    var updated_at:String?
    static func fetchCategories(countryId:Int,completionHandler:@escaping ([Category],Bool) -> () ) {
            let url = URL(string:"https://fitnessksa.com/public/api/category/\(countryId)")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                var categories = [Category]()
                var loadedData:Bool = true
                if error != nil
                {
                    loadedData = false
                    /*customErrorMessage = "Something Went Wrong! Make sure you are connected to the internet!"*/
                }
                else
                {
                    if (response as? HTTPURLResponse)?.statusCode == 200 {
                        do
                        {
                            let allCategories = try JSONDecoder().decode([Category].self,from: data!)
                            categories = allCategories
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
                    
                    completionHandler(categories,loadedData)
                }
                }.resume()
    }
}
