//
//  SectionItems.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import SVProgressHUD
class SubSubCategoryItems: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let cellId = "cellId"
    
    var subSubCategory:SubSubCategory?
    {
        didSet{
            title = subSubCategory?.name
            SVProgressHUD.show()
            guard let subSubCatId = subSubCategory?.sub_category_id else {return}
            guard let subCatId = subSubCategory?.id else {return}
            APIService.shared.fetchListItems(subCategory:subCatId, subSubCategory: subSubCatId) { (listitems) in
                print(subCatId)
                self.allListItems = listitems
                self.collectionView?.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    var subCategory:SubCategory?
    {
        didSet
        {
            title = subCategory?.name

            SVProgressHUD.show()
            if let subCategoryId = subCategory?.id
            {
                print(subCategoryId)
                APIService.shared.fetchListItems(subCategory:subCategoryId, subSubCategory: 0) { (listitems) in
                    self.allListItems = listitems
                    self.collectionView?.reloadData()
                    print("loaded list items")
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    
    var allListItems:[ListItem]?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView?.register(SubCategoryItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .lightGray
    }
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    @IBAction func goBackToSections(_ sender: Any) {
        SVProgressHUD.dismiss()
        navigationController?.popViewController(animated: true)
    }
    
}
