//
//  ListItem.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/10/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
struct ListItem:Codable
{
    var id:Int?
    var sub_category_id: Int?
    var sub_sub_category_id: Int?
    var image : String?
    var title:String?
    var details:String?
    var facebook_link:String?
    var instagram_link:String?
    var twitter_link:String?
    var website_link:String?
    var android_store_link:String?
    var app_store_link:String?
    var youtube_link:String?
    var created_at:String?
    var updated_at:String?
}
