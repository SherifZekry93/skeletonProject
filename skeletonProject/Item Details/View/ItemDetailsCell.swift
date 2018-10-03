//
//  Items.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class ItemDetailsCell: UICollectionViewCell {
    var homeController:ItemDetailsViewController?
    var listItem:ListItem?{
        didSet
        {
            guard let listItem = listItem else {return}
            if let title = listItem.title
            {
                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
                
                guard let subTitle = listItem.details else {return }
                if subTitle != ""
                {
                attributedText.append(NSAttributedString(string: "\n\(subTitle)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),NSAttributedStringKey.foregroundColor:UIColor.lightGray]))
                }
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                titleLabel.attributedText = attributedText
                
                titleLabel.textAlignment = .right
            }
            if let imageName = listItem.image
            {
                if imageName != ""
                {
                    //print(imageName)
                    guard let imageURL = URL(string:"https://fitnessksa.com/public/images/posts/" + imageName)
                        else {
                            return
                    }
                    //print(imageURL)
                    itemImage.sd_setImage(with:imageURL, completed: nil)
                   // itemImage.downloadImage(from: imageURL)
                }
            }
         
                if UserDefaults.standard.exisitingItem(checkedListItem: listItem)
                {
 starButton.setImage(#imageLiteral(resourceName: "filledstar").withRenderingMode(.alwaysOriginal), for: .normal)
                    
            }
            
        }
    }
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = .white
        setupAutoLayout()
    }
    func setupAutoLayout()
    {
        addSubview(itemImage)
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: topAnchor),
            itemImage.rightAnchor.constraint(equalTo: rightAnchor),
            itemImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            itemImage.widthAnchor.constraint(equalToConstant: 100)
            ])
        addSubview(titleLabel)
        
        addSubview(starButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: itemImage.leftAnchor, constant: -5),
            titleLabel.leftAnchor.constraint(equalTo: starButton.rightAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        starButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            starButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            starButton.widthAnchor.constraint(equalToConstant: 40),
            starButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        starButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
    }
    let starButton : UIButton = {
        let startButton = UIButton(type: .system)
        startButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        startButton.setImage(UIImage(named: "ic_white_empty_star"), for: .normal)
        startButton.tintColor = UIColor.darkGray
        startButton.contentMode = .scaleAspectFit
        return startButton
    }()
    let titleLabel : UILabel = {
        let label = UILabel();
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    let itemImage : UIImageView = {
        let image = UIImageView()
        image.sd_setIndicatorStyle(.gray)
        image.sd_showActivityIndicatorView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "img_blank")
        return image
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func addToFavourite()
    {
        guard let currentListItem = listItem else {return}

        if !UserDefaults.standard.exisitingItem(checkedListItem: currentListItem)
        {
            UserDefaults.standard.favoriteItem(checkedListItem: currentListItem)
 starButton.setImage(#imageLiteral(resourceName: "filledstar").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else
        {
            if UserDefaults.standard.exisitingItem(checkedListItem: currentListItem, delete: true)
            {
                starButton.setImage(UIImage(named: "ic_white_empty_star"), for: .normal)
                starButton.tintColor = .darkGray
                guard let favoriteMode = homeController?.favoriteMode else {return}
                if favoriteMode
                {
                    homeController?.deleteItem(dataItem: currentListItem)
                }
            }
        }
    }
}
