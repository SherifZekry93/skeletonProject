//
//  SubSubCategoryExtension.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/9/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
extension ItemDetailsViewController
{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if let count = allListItems?.count
        {
            return count
        }
        else if let count = dataListItem?.count
        {
            return count
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let layout = UICollectionViewFlowLayout()
        let controller = SingleItemCollectionViewController(collectionViewLayout: layout)
        if let listItem = allListItems?[indexPath.item]
        {
            controller.listItem = listItem
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 6)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemDetailsCell
        if let item = allListItems?[indexPath.item]
        {
            cell.listItem = item
        }
        return cell
    }
}

