//
//  ViewController.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit

class HomeViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var uibuttonView: UIView!
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
    var allCountries:[Country]?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.blue
        uibuttonView.backgroundColor = UIColor.blue
        addButtonOutlet.layer.cornerRadius = 15
        fetchCountries { (allCountries) in
            self.allCountries = allCountries
            self.collectionView.reloadData()
        }
        
    }
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let countries = allCountries
        {
            return countries.count
        }
        return 0
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CountryCell
        if let country = allCountries?[indexPath.item]
        {
            cell.country = country
        }
        //cell.countryName.text = "هذا بلد"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 15, height: 40)
    }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CountrySectionSegue", sender: self)
    }
}
