//
//  CountrySectionCell.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class CategoryCell: UICollectionViewCell {
    var category:Category?{
        didSet{
            if let sectionName = category?.name
            {
                sectionLabel.text = sectionName
            }
            let imageBaseUrl = "https://fitnessksa.com/public/images/categories/"
            if let imageName = category?.image
            {
                if let url = URL(string: imageBaseUrl+imageName)
                {
                    sectionImage.downloadImage(from: url)
                }
            }
        }
    }
    let sectionLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "التسويق \n الالكتزوني"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let sectionImage:UIImageView = {
       let image = UIImageView()
       image.contentMode = .scaleAspectFit
        
       return image
    }()
    let gradientView:UIView = {
        let uiview = UIView()
        uiview.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return uiview
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(sectionImage)
        addSubview(gradientView)
        gradientView.addSubview(sectionLabel)
        gradientView.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        sectionImage.anchorToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        sectionLabel.anchorToTop(top: gradientView.topAnchor, left: gradientView.leftAnchor, bottom: gradientView.bottomAnchor, right: gradientView.rightAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
