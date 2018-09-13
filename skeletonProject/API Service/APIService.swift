//
//  APIService.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/9/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
class APIService {
     static let shared = APIService()
     func fetchCategories(countryId:Int,completionHandler:@escaping ([Category],Bool) -> () ) {
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
    func fetchCountries(completionHandler:@escaping ([Country],Bool) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/country")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var countries = [Country]()
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
    func fetchSubCategories(categoryId:Int,completionHandler:@escaping ([SubCategory],Bool) -> () ) {
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
                    catch let error
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
    func fetchSubSubCategories(subcategoryId:Int,completionHandler:@escaping ([SubSubCategory],Bool) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/sub-sub-category/\(subcategoryId)")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var subSubCategories = [SubSubCategory]()
            var loadedData:Bool = true
            if error != nil
            {
                loadedData = false
                print("here is an error")
            }
            else
            {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    do
                    {
                        let allSubCategories = try JSONDecoder().decode([SubSubCategory].self,from: data!)
                        subSubCategories = allSubCategories
                        print(subSubCategories)
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
                
                completionHandler(subSubCategories,loadedData)
            }
            }.resume()
    }
    func fetchListItems(subCategory:Int,subSubCategory:Int,completitionHandler:@escaping ([ListItem]) -> ()) {
        let listItemsUrlString: String = "https://fitnessksa.com/public/api/list-items?subCategory=\(subCategory)&subSubCategory=\(subSubCategory)"
        print(listItemsUrlString)
        guard let listItemsURL = URL(string: listItemsUrlString) else {
            print("Error: cannot create URL")
            return
        }
        var listItemsUrlRequest = URLRequest(url: listItemsURL)
        print("here is the url"+listItemsUrlString)
        listItemsUrlRequest.httpMethod = "POST"
        print(listItemsUrlString)
        URLSession.shared.dataTask(with: listItemsUrlRequest)
        {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error!)
                return
            }
            var allItems:[ListItem]  = [ListItem]()
           
            do
            {
                if  data != nil
                {
                    allItems = try JSONDecoder().decode([ListItem].self, from: data!)
                    print("here is all items")
                }
                else
                {
                    print("parsed with no data")
                }
               
            }
            catch let error
            {
                print("error parsing data by decoder \(error)")
            }
            DispatchQueue.main.async
            {
                    completitionHandler(allItems)
            }
//            let dataString = String(data:responseData,encoding:.utf8)
//            print("here is the data" + dataString!)
        }.resume()
       // task.resume()
    }
    
}
