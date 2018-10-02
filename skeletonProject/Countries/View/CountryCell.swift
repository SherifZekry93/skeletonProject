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
                countryImage.downloadImage(from: url)
            }
        }
    }
    let countryName:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .blue
        return label
    }()
    let countryImage:CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.backgroundColor = .gray
        image.image = nil
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
  
    override func prepareForReuse() {
        countryImage.image = nil
    }
}
