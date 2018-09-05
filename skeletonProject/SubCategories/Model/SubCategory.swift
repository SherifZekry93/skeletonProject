//
//  SubCategory.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/5/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
struct SubCategory : Codable
{
    var id:Int?
    var category_id:Int?
    var name:String?
    var created_at:String
    var updated_at:String?
    static func fetchCategories(categoryId:Int,completionHandler:@escaping ([SubCategory],Bool) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/sub-categories/\(categoryId)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var subCategories = [SubCategory]()
            var loadedData:Bool = true
            if error != nil
            {
                loadedData = false
            }
            else
            {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    do
                    {
                        let allSubCategories = try JSONDecoder().decode([SubCategory].self,from: data!)
                        subCategories = allSubCategories
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
                
                completionHandler(subCategories,loadedData)
            }
            }.resume()
    }
}
