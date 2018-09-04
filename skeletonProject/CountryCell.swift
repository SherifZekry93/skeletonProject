//
//  CountryCell.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class CountryCell:UICollectionViewCell
{
    var country:Country?{
        didSet{
            if let name = country?.name
            {
                countryName.text = name
            }
            let imageBaseUrl = "https://fitnessksa.com/public/images/countries/"
            var imageurl:String = ""
            if let imageName = country?.image
            {
                imageurl = imageBaseUrl+imageName
            }
            
            if let url = URL(string: imageurl) {
                downloadImage(from: url)
            }

        }
    }
    let countryName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    let countryImage:UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named:"flag")
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }
    func setupLayout()
    {
        addSubview(countryName)
        addSubview(countryImage)
      

        countryName.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 50, bottomConstant: 5, rightConstant: 5)
    countryImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                countryImage.widthAnchor.constraint(equalToConstant: 30),
                countryImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                countryImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
                countryImage.heightAnchor.constraint(equalToConstant:30)
            ]
        )
        countryImage.layer.cornerRadius = 15
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.countryImage.image = UIImage(data: data)
            }
        }
    }

}