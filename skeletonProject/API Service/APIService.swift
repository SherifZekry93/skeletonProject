//
//  APIService.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/9/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
var dataTask:URLSessionDataTask?
class APIService {
     static let shared = APIService()
     func fetchCategories(countryId:Int,completionHandler:@escaping ([Category],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/category/\(countryId)") else {return}
        dataTask?.cancel()
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            var categories = [Category]()
            var loadedData:Bool = true
            if error != nil
            {
                loadedData = false
                print("error\(error)" )
            }
            else
            {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    do
                    {
                        if let responseData = data
                        {
                            let allCategories = try JSONDecoder().decode([Category].self,from: responseData)
                            categories = allCategories

                        }
                    }
                    catch let error
                    {
                        print("here is the reason why it's not loading egypt")
                        print(error.localizedDescription)
                        print(error)
                        loadedData = false
                    }
                }
                else
                {
                    loadedData = false
                    print((response as! HTTPURLResponse).statusCode)
                }
            }
            DispatchQueue.main.async {
                
                completionHandler(categories,loadedData)
            }
            }//.resume()
        dataTask?.resume()
    }
    func fetchCountries(completionHandler:@escaping ([Country],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/country") else {return}
        dataTask?.cancel()
        dataTask =  URLSession.shared.dataTask(with: url) { (data, response, error) in
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
            
            }//.resume()
        dataTask?.resume()
    }
    func fetchSubCategories(categoryId:Int,completionHandler:@escaping ([SubCategory],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/sub-categories/\(categoryId)") else {return}
        dataTask?.cancel()
       dataTask =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            
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
            }//.resume()
        dataTask?.resume()
    }
    func fetchSubSubCategories(subcategoryId:Int,completionHandler:@escaping ([ItemDetails],Bool) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/sub-sub-category/\(subcategoryId)")
        dataTask?.cancel()
        dataTask =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            var subSubCategories = [ItemDetails]()
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
                        let allSubCategories = try JSONDecoder().decode([ItemDetails].self,from: data!)
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
            }//.resume()
        dataTask?.resume()
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
        dataTask?.cancel()
        dataTask =  URLSession.shared.dataTask(with: listItemsUrlRequest)
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
                    print(allItems)
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
        }//.resume()
        dataTask?.resume()
       // task.resume()
    }
    
}
