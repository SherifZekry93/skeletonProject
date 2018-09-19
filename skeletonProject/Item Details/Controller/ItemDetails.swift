//
//  SectionItems.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreData
protocol controlDataDeletion {
    func deleteItem(dataItem:DataListItem)
    func markAsNotFavourite(listItem:ListItem, isfavourited:Bool)
}
class ItemDetailsViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,controlDataDeletion {
    
    func markAsNotFavourite(listItem: ListItem,isfavourited:Bool)
    {
        let index = allListItems?.index(of: listItem)
        let indexPath = IndexPath(item: index!, section: 0)
        let cell =  collectionView?.cellForItem(at: indexPath) as! ItemDetailsCell
        cell.starButton.tintColor = isfavourited ? .orange : .gray
    }
    func deleteItem(dataItem: DataListItem)
    {
        if let index = dataListItem?.index(of: dataItem)
        {
            dataListItem?.remove(at: index)
            self.collectionView?.reloadData()
        }
    }
    let cellId = "cellId"
    var subSubCategory:ItemDetails?
    {
        didSet{
            title = subSubCategory?.name
            SVProgressHUD.show()
            guard let subSubCatId = subSubCategory?.sub_category_id else {return}
            guard let subCatId = subSubCategory?.id else {return}
            APIService.shared.fetchListItems(subCategory:subCatId, subSubCategory: subSubCatId) { (listitems,loaddata) in
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
                APIService.shared.fetchListItems(subCategory:subCategoryId, subSubCategory: 0) { (listitems,loaddata) in
                    print(loaddata)
                    if loaddata
                    {
                        self.allListItems = listitems
                        //self.collectionView?.reloadData()
                        SVProgressHUD.dismiss()
                    }
                    else if loaddata == false
                    {
                      self.present(UIAlertController.showAlert(message: "Error loading data. Please make sure you are connected to the internet"), animated: true, completion: nil)
                        SVProgressHUD.dismiss()
                    }
                    
                }
            }
        }
    }
    var allListItems:[ListItem]?{
        didSet{
            self.collectionView?.reloadData()
        }
    }
    var dataListItem:[DataListItem]?{
        didSet
        {
            self.collectionView?.reloadData()
            title = "المفضلة"
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView?.register(ItemDetailsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .lightGray
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon-right")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    @objc func goBack() {
        SVProgressHUD.dismiss()
        navigationController?.popViewController(animated: true)
    }
    func loadData() -> [DataListItem]
    {
        return CoreDataManager.shared.loadData()
    }
    
}
