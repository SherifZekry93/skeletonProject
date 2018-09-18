//
//  SingleItemCollectionViewController.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/13/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SingleItemCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let itemDetailsCellId = "itemDetailsId"
    var listItem:ListItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(SingleItemCollectionViewCell.self, forCellWithReuseIdentifier: itemDetailsCellId)
        view.backgroundColor = .white
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height:CGFloat = 100
        guard let details = listItem?.details else { return CGSize(width: view.frame.width, height: view.frame.height)}
        let size = CGSize(width: view.frame.width - 55, height: 10000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: details ).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)], context: nil)
        print(estimatedRect.size.height)
        if Int(estimatedRect.size.height) > 100
        {
            height = estimatedRect.size.height + 500
            if height > view.frame.height
            {
                return CGSize(width: view.frame.width, height: height)
            }
            else
            {
                 return CGSize(width: view.frame.width, height: view.frame.height)
            }
        }
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemDetailsCellId, for: indexPath) as! SingleItemCollectionViewCell
        if let cellListItem = listItem
        {
            cell.listItem = cellListItem
        }
        return cell
    }
}
