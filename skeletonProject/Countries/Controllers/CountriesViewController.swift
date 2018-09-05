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
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "تحميل الدول")
        collectionViewCustomize()
        customizeNavBar()
        fetchCountries { (allCountries) in
            self.allCountries = allCountries
            self.collectionView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    //MARK:- Change Navigation Top Bar
    func customizeNavBar()
    {
        navigationController?.navigationBar.barTintColor = UIColor.blue
        uibuttonView.backgroundColor = UIColor.blue
        addButtonOutlet.layer.cornerRadius = 15
    }
    //MARK:- Load All Countries
    func fetchCountries(completionHandler:@escaping ([Country]) -> () ) {
        let url = URL(string:"https://fitnessksa.com/public/api/country")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            print("inside closure")
            var countries = [Country]()
            var customErrorMessage:String = ""
            if error != nil
            {
                customErrorMessage = "Something Went Wrong! Make sure you are connected to the internet!"
            }
            else
            {
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    do
                    {
                        let allCountries = try JSONDecoder().decode([Country].self,from: data!)
                        countries = allCountries
                    }
                    catch
                    {
                        customErrorMessage = "Something Went Wrong! Make sure you are connected to the internet!"
                    }
                }
                else
                {
                    customErrorMessage = "Something Went Wrong! Make sure you are connected to the internet!"
                }
            }
            DispatchQueue.main.async {
                if !(customErrorMessage.isEmpty)
                {
                    let uiAlert = UIAlertController(title: "Error!", message: customErrorMessage, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok!",style:.cancel, handler: nil)
                    uiAlert.addAction(action)
                   self.present(uiAlert, animated: true, completion: nil)
                }
                else
                {
                    
                }
                completionHandler(countries)

            }
            
            }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = titleText
    }
    
    let cellId = "cellId"
    //MARK:- Prepare for new segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "CountrySectionSegue"
        {
            let dest = segue.destination as! CountrySection
            let item = collectionView.indexPathsForSelectedItems?.first
            let id = allCountries?[(item?.item)!].id
            dest.countryId = id
        }
    }
}
