//
//  CountrySections.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import SVProgressHUD
class CountrySection: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    var countryId:Int?
    {
        didSet
        {
        
            fetchSections { (allCategories) in
                self.allCategories = allCategories
                self.collectionView.reloadData()
            }
        }
    }
    var allCategories:[Category]?
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SectionsSegue", sender: self)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! CountrySectionCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        if let category = allCategories?[indexPath.item]
        {
            cell.category = category
        }
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CountrySectionCell.self, forCellWithReuseIdentifier: "id")
        setupTitleStack()
        
      
    }
    func fetchSections(completionHandler:@escaping ([Category]) -> () ) {
        if let id = countryId
        {
            let url = URL(string:"https://fitnessksa.com/public/api/category/\(id)")
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                var categories = [Category]()
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
                            let allCategories = try JSONDecoder().decode([Category].self,from: data!)
                            categories = allCategories
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
                    completionHandler(categories)
                }
                
                }.resume()

        }
        else
        {
            return
        }
    }
    func setupTitleStack()
    {
        let size = (view.frame.size.width - 20)
        navigationItem.hidesBackButton = true
        let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "ic_white_more"), for: .normal)
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "ic_white_reply"), for: .normal)
        let favButton = UIButton()
        favButton.setImage(UIImage(named: "ic_white_empty_star"), for: .normal)
        let titleLabel = UILabel()
        titleLabel.text = "مصر"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        let countryImage = UIImageView()
        countryImage.image = UIImage(named: "flag")
        countryImage.clipsToBounds = true
        countryImage.layer.cornerRadius = 20
        let backToPrevious = UIButton()
        backToPrevious.setImage(UIImage(named: "ic_rtl_back"), for: .normal)
        let titleView = UIView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        titleView.addSubview(menuButton)
        titleView.addSubview(backButton)
        titleView.addSubview(favButton)
        titleView.addSubview(titleLabel)
        titleView.addSubview(countryImage)
        titleView.addSubview(backToPrevious)
        //titleView.backgroundColor = .red
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuButton.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            menuButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            menuButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            menuButton.widthAnchor.constraint(equalToConstant: 80/3)
            ])
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor),
            backButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            backButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 80/3)
            ])
        
        
        favButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor),
            favButton.topAnchor.constraint(equalTo: titleView.topAnchor),
            favButton.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            favButton.widthAnchor.constraint(equalToConstant: 80/3)
            ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: favButton.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: size - 160)
            ])
        
        countryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            countryImage.topAnchor.constraint(equalTo: titleView.topAnchor,constant:5),
            countryImage.bottomAnchor.constraint(equalTo: titleView.bottomAnchor,constant:-5),
            countryImage.widthAnchor.constraint(equalToConstant: 40)
            ])
        backToPrevious.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backToPrevious.leadingAnchor.constraint(equalTo: countryImage.trailingAnchor),
            backToPrevious.topAnchor.constraint(equalTo: titleView.topAnchor),
            backToPrevious.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            backToPrevious.widthAnchor.constraint(equalToConstant: 40)
            ])
        navigationItem.titleView = titleView
    }

}

