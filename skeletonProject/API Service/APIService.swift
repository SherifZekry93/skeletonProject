//
//  APIService.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/9/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
import Alamofire
var dataTask:URLSessionDataTask?
class APIService {
    static let shared = APIService()
    func fetchCategories(countryId:Int,completionHandler:@escaping ([Category],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/category/\(countryId)") else {return}
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            var categories = [Category]()
            var loadedData:Bool = true
            if response.result.isSuccess
            {
                guard let data = response.data else {loadedData = false; return}
                do
                {
                    let allCategories = try JSONDecoder().decode([Category].self,from: data)
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
            DispatchQueue.main.async
                {
                    completionHandler(categories,loadedData)
            }
        }
    }
    func fetchCountries(completionHandler:@escaping ([Country],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/country") else {return}
        Alamofire.request(url, method : .get, parameters: nil).responseJSON{
            response in
            var countries = [Country]()
            var loadedData:Bool = true
            if response.result.isSuccess
            {
                do
                {
                    guard let data = response.data else{loadedData = false; return}
                    let allCountries = try JSONDecoder().decode([Country].self,from: data)
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
            DispatchQueue.main.async {
                completionHandler(countries,loadedData)
            }
        }
    }
    func fetchSubCategories(categoryId:Int,completionHandler:@escaping ([SubCategory],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/sub-categories/\(categoryId)") else {return}
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            
            var subCategories = [SubCategory]()
            var loadedData:Bool = true
            if response.result.isSuccess
            {
                do
                {
                    guard let data = response.data else {loadedData = false; return}
                    let allSubCategories = try JSONDecoder().decode([SubCategory].self,from: data)
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
            DispatchQueue.main.async {
                completionHandler(subCategories,loadedData)
            }
        }
    }
    func fetchSubSubCategories(subcategoryId:Int,completionHandler:@escaping ([ItemDetails],Bool) -> () ) {
        guard let url = URL(string:"https://fitnessksa.com/public/api/sub-sub-category/\(subcategoryId)") else {return}
        Alamofire.request(url, method: .get, parameters: nil).responseJSON{
            response in
            var subSubCategories = [ItemDetails]()
            var loadedData:Bool = true
            if response.result.isSuccess
            {
                   guard let data = response.data else {loadedData = false; return}
                do
                {
                    let allSubCategories = try JSONDecoder().decode([ItemDetails].self,from: data)
                    subSubCategories = allSubCategories
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
            DispatchQueue.main.async
            {
                completionHandler(subSubCategories,loadedData)
            }
        }
    }
    func fetchListItems(subCategory:Int,subSubCategory:Int,completitionHandler:@escaping ([ListItem],Bool) -> ()) {
        let params: [String : Int] = ["subCategory":subCategory, "subSubCategory":subSubCategory];
        var loadedData = true
        let url = "https://fitnessksa.com/public/api/list-items"
        var allItems:[ListItem]  = [ListItem]()
        
        Alamofire.request(url, method : .post, parameters: params).responseJSON{
            response in
            if response.result.isSuccess
            {
                guard let data = response.data else {loadedData = false;return}
                do
                {
                        allItems = try JSONDecoder().decode([ListItem].self, from: data)
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
            DispatchQueue.main.async
            {
                completitionHandler(allItems,loadedData)
            }
        }
    }
}
