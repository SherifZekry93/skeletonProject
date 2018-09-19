//
//  CoreDataManager.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/19/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class CoreDataManager
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static let shared = CoreDataManager()
    func exisistingItem(id:Int,delete:Bool) -> Bool
    {
        let request:NSFetchRequest<DataListItem> = DataListItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@",NSNumber(value : id))
        let fetchedMessage = try? context.fetch(request)
        guard let messageId = fetchedMessage?.first?.id else {return false}
        if id == Int(messageId)
        {
            if delete
            {
                if let item = fetchedMessage?.first
                {
                    context.delete(item)
                }
            }
            return true
        }
        else
        {
            return false
        }
    }
    func loadData() -> [DataListItem]
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<DataListItem> = DataListItem.fetchRequest()
        var allDataListItems = [DataListItem]()
        do
        {
            allDataListItems = try context.fetch(fetchRequest)
        }
        catch
        {
            
        }
        return allDataListItems
    }
}
