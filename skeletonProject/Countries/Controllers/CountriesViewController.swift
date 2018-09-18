//
//  ViewController.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import SVProgressHUD
class AllCountriesViewController:UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var uibuttonView: UIView!
    let cellId = "cellId"
    var allCountries:[Country]?
    let titleText : UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.textAlignment = .center
        let attributedString = NSMutableAttributedString(string: "البوابة الشاملة\n", attributes: [
            NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 16),
            NSAttributedStringKey.foregroundColor:UIColor.white
            ])
        attributedString.append(NSAttributedString(string: "للمواقع و تطبيقات الهواتف\n", attributes: [
            NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 13),
            NSAttributedStringKey.foregroundColor:UIColor.white
            ]))
        
        textView.attributedText = attributedString
        textView.textAlignment = .center
        return textView
    }()
    var loadedData:Bool = false
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "تحميل الدول")
        collectionViewCustomize()
        customizeNavBar()
        APIService.shared.fetchCountries { (allCountries,loadedData) in
            self.allCountries = allCountries
            self.allCountries?.swapAt(0, 1)
            self.loadedData = loadedData
            if loadedData
            {
                self.collectionView.reloadData()
            }
            else
            {
                self.present(UIAlertController.showAlert(message: "Error loading data. Please make sure you are connected to the internet"), animated: true, completion: nil)
            }
            SVProgressHUD.dismiss()
        }
    }
    //MARK:- Customize Navigation Bar
    func customizeNavBar()
    {
        navigationController?.navigationBar.barTintColor = UIColor.blue
        uibuttonView.backgroundColor = UIColor.blue
        addButtonOutlet.layer.cornerRadius = 15
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    //MARK:- Load All Countries
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = titleText
    }
    
    //MARK:- Prepare for new segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CategoriesSegue"
        {
            let dest = segue.destination as! Categories
            let item = collectionView.indexPathsForSelectedItems?.first
            guard let id = allCountries?[(item?.item)!].id else {return}
            guard let imageName = allCountries![(item?.item)!].image else {return}
            guard let countryName = allCountries![(item?.item)!].name else {return}
            dest.countryId = id
            dest.countryName = countryName
            dest.imageName = imageName
        }
    }
}
