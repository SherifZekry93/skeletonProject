//
//  CodeData.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 10/3/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import Foundation
extension UserDefaults
{
    static let userdefaultsKey = "fetchfavorites"
    func getFavoritedItems() -> [ListItem]
    {
        if let data = UserDefaults.standard.data(forKey: UserDefaults.userdefaultsKey)
        {
            if let userDefaultsItems = NSKeyedUnarchiver.unarchiveObject(with: data) as? [ListItem]
            {
                return userDefaultsItems
            }
        }
        return [ListItem]()
    }
    func exisitingItem(checkedListItem:ListItem,delete:Bool = false) -> Bool
    {
        var savedListItems = getFavoritedItems()
        let hasFavorited = savedListItems.index { (listitem) -> Bool in
            checkedListItem.id == listitem.id &&
            checkedListItem.title == listitem.title
        }
        if hasFavorited != nil
        {
            if delete
            {
                savedListItems = savedListItems.filter({
                    $0.id != checkedListItem.id
                })
                let archivedDataToSave = NSKeyedArchiver.archivedData(withRootObject: savedListItems)
                UserDefaults.standard.setValue(archivedDataToSave, forKey: UserDefaults.userdefaultsKey)
            }
            return true
        }
        return false
    }
    func favoriteItem(checkedListItem:ListItem)
    {
        var savedListItems = getFavoritedItems()
        savedListItems.append(checkedListItem)
        let archivedDataToSave = NSKeyedArchiver.archivedData(withRootObject: savedListItems)
        setValue(archivedDataToSave, forKey: UserDefaults.userdefaultsKey)
    }
}
