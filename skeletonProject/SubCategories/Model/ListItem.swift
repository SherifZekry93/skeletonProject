//
//  ListItem.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/10/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
class ListItem:NSObject, Codable, NSCoding
{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "listItemIDKey")
        aCoder.encode(sub_category_id, forKey: "subCategoryIDKeg")
        aCoder.encode(sub_sub_category_id, forKey: "subSubCategoryIDKey")
        aCoder.encode(image, forKey: "imageURLKey")
        aCoder.encode(title, forKey: "titleKey")
        aCoder.encode(details, forKey: "detailsKey")
        aCoder.encode(facebook_link, forKey: "facebookLinkKey")
        aCoder.encode(instagram_link, forKey: "instagramLinkKey")
        aCoder.encode(twitter_link, forKey: "twitterLinkKey")
        aCoder.encode(website_link, forKey: "websiteLinkKey")
        aCoder.encode(android_store_link, forKey: "androidStoreKey")
        aCoder.encode(app_store_link, forKey: "appstoreLinkKey")
        aCoder.encode(youtube_link, forKey: "youtubeLinkKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id =  aDecoder.decodeObject(forKey: "listItemIDKey") as? Int
        self.sub_category_id = aDecoder.decodeObject(forKey: "subCategoryIDKeg") as? Int
        self.sub_sub_category_id = aDecoder.decodeObject(forKey: "subSubCategoryIDKey") as? Int
        self.image = aDecoder.decodeObject(forKey: "imageURLKey") as? String
        self.title =  aDecoder.decodeObject(forKey: "titleKey") as? String
        self.details = aDecoder.decodeObject(forKey: "detailsKey") as? String
        self.facebook_link = aDecoder.decodeObject(forKey: "facebookLinkKey") as? String
        self.instagram_link = aDecoder.decodeObject(forKey: "instagramLinkKey") as? String
        self.twitter_link = aDecoder.decodeObject(forKey: "twitterLinkKey") as? String
        self.website_link = aDecoder.decodeObject(forKey: "websiteLinkKey") as? String
        self.android_store_link = aDecoder.decodeObject(forKey: "androidStoreKey") as? String
        self.app_store_link = aDecoder.decodeObject(forKey: "appstoreLinkKey") as? String
        self.youtube_link = aDecoder.decodeObject(forKey: "youtubeLinkKey") as? String
    }
    
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
