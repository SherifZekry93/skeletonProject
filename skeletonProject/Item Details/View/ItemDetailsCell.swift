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

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func loadData(id:Int,delete:Bool) -> Bool
    {
        return CoreDataManager.shared.exisistingItem(id:id,delete:delete)
    }
    var dataItem:DataListItem?{
        didSet{
            if let title = dataItem?.title
            {
                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
                
                guard let subTitle = dataItem?.details else {return }
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
            if let imageName = dataItem?.image
            {
                if imageName != ""
                {
                    //print(imageName)
                    guard let imageURL = URL(string:"https://fitnessksa.com/public/images/posts/" + imageName)
                        else {
                            return
                    }
                    print(imageURL)
                    itemImage.downloadImage(from: imageURL)
                }
            }
            if let id = dataItem?.id
            {
                if loadData(id: Int(id), delete: false)
                {
                    starButton.tintColor = .orange
                }
            }
        }
    }
    var listItem:ListItem?{
        didSet
        {
            if let title = listItem?.title
            {
                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)])
                
                guard let subTitle = listItem?.details else {return }
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
            if let imageName = listItem?.image
            {
                if imageName != ""
                {
                    print(imageName)
                    guard let imageURL = URL(string:"https://fitnessksa.com/public/images/posts/" + imageName)
                        else {
                            return
                    }
                    print(imageURL)
                    itemImage.downloadImage(from: imageURL)
                }
            }
            if let id = listItem?.id
            {
                if loadData(id: id, delete: false)
                {
                    starButton.tintColor = .orange
                }
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
            starButton.widthAnchor.constraint(equalToConstant: 40)
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
    let itemImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "img_blank")
        return image
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func addToFavourite()
    {
        var id:Int?
        if let itemId = listItem?.id
        {
            id = itemId
        }
        if let dataItemId = dataItem?.id
        {
            id = Int(dataItemId)
            guard let dataItemToRemove = dataItem else {return}
            guard let indexToRemove = homeController?.dataListItem?.index(of: dataItemToRemove) else {return}
            homeController?.dataListItem?.remove(at: indexToRemove)
        }
        guard let itemId = id else {return}
        if loadData(id: itemId, delete: true)
        {
            starButton.tintColor = .gray
        }
        else
        {
            let modelListItem = DataListItem(context: context)
            if let id = listItem?.id
            {
                modelListItem.id = Int64(id)
            }
            if let appstoreLink = listItem?.app_store_link
            {
                modelListItem.app_store_link = appstoreLink
            }
            if let instagramLink = listItem?.instagram_link
            {
                modelListItem.instagram_link = instagramLink
            }
            if let details = listItem?.details
            {
                modelListItem.details = details
            }
            if let image = listItem?.image
            {
                modelListItem.image = image
            }
            if let twitter = listItem?.twitter_link
            {
                modelListItem.twitter_link = twitter
            }
            if let websiteLink = listItem?.website_link
            {
                modelListItem.website_link = websiteLink
            }
            if let title = listItem?.title
            {
                modelListItem.title = title
            }
            if let facebook = listItem?.facebook_link
            {
                modelListItem.facebook_link = facebook
            }
            starButton.tintColor = .orange
        }
        do
        {
            try context.save()
        }
        catch
        {
            print("error saving data")
        }
    }
}
