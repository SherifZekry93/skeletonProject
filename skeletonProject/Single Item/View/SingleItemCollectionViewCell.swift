//
//  SingleItemCollectionViewCell.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/13/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
import CoreData
class SingleItemCollectionViewCell: UICollectionViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var itemsDelegate:ItemDetailsViewController?
//    func loadData(id:Int,delete:Bool) -> Bool
//    {
//        return CoreDataManager.shared.exisistingItem(id:id,delete:delete)
//    }
    var height:CGFloat?{
        didSet{
            setupLayout()
        }
    }
    var homeController:SingleItemCollectionViewController?
    var listItem:ListItem?{
        didSet{
            guard let listItem = listItem else {return}
            if let title = listItem.title
            {
                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
                guard let subTitle = listItem.details else {return }
                if subTitle != ""
                {
                    attributedText.append(NSAttributedString(string: "\n\(subTitle)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 13),NSAttributedStringKey.foregroundColor:UIColor.darkGray]))
                }
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
                titleLabel.attributedText = attributedText
                titleLabel.textAlignment = .right
                let size = CGSize(width: frame.width - 55, height: 10000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: titleLabel.text ?? "").boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 15)], context: nil)
                if Int(estimatedRect.size.height) > 100
                {
                    height = estimatedRect.size.height + 50 //+ 35
                }
                else
                {
                    height = 100
                }
            }
            if listItem.id != nil
            {
                if UserDefaults.standard.exisitingItem(checkedListItem: listItem)
                {
                    starButton.tintColor = .orange
                }
            }
            if listItem.instagram_link == "" || listItem.instagram_link == nil
            {
                instagramButton.setImage(UIImage(named: ""), for: .normal)
            }
            if listItem.youtube_link == "" || listItem.youtube_link == nil
            {
                youtubeButton.setImage(UIImage(named: ""), for: .normal)
            }
            if listItem.facebook_link == "" || listItem.facebook_link == nil
            {
                facebookButton.setImage(UIImage(named: ""), for: .normal)
            }
            if listItem.app_store_link == "" || listItem.app_store_link == nil
            {
                appStoreButton.setImage(UIImage(named: ""), for: .normal)
            }
            if listItem.website_link == "" || listItem.website_link == nil
            {
                websiteeButton.setImage(UIImage(named: ""), for: .normal)
            }
            if listItem.twitter_link == "" || listItem.twitter_link == nil
            {
                twitterButton.setImage(UIImage(named: ""), for: .normal)
            }
        }
    }
    let titleLabel : UILabel = {
        let label = UILabel();
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starButton : UIButton = {
        let startButton = UIButton(type: .system)
        startButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        startButton.setImage(UIImage(named: "ic_white_empty_star"), for: .normal)
        startButton.tintColor = UIColor.gray
        startButton.contentMode = .scaleAspectFit
        startButton.translatesAutoresizingMaskIntoConstraints = false
        return startButton
    }()
    
    let itemImage : CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleToFill
        image.image = UIImage(named: "img_blank")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let containerView:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    let socialContainer:UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    let facebookButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"facebook"), for: .normal)
        button.tag = 0
        return button
    }()
    let instagramButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"instagram"), for: .normal)
        button.tag = 1
        return button
    }()
    let appStoreButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"appstore"), for: .normal)
        button.tag = 2
        return button
    }()
    let websiteeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"website"), for: .normal)
        button.tag = 3
        return button
    }()
    let youtubeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"youtube"), for: .normal)
        button.tag = 4
        return button
    }()
    let twitterButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"twitter"), for: .normal)
        button.tag = 5
        return button
    }()
    lazy var firstRowStackView:UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [facebookButton,instagramButton,appStoreButton])
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.distribution = .fillEqually
        stackV.spacing = 4
        return stackV
    }()
    lazy var secondRowStackView:UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [websiteeButton,twitterButton,youtubeButton])
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.distribution = .fillEqually
        stackV.spacing = 4
        return stackV
    }()
    
    lazy var stackView:UIStackView = {
        let stackV = UIStackView(arrangedSubviews: [firstRowStackView,secondRowStackView])
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.distribution = .fillEqually
        stackV.spacing = 4
        return stackV
    }()
  

    @objc func addToFavourite()
    {
//        var id:Int?
//
//        if let itemId = listItem?.id
//        {
//           id = itemId
//        }
        if let item = listItem
        {
        if UserDefaults.standard.exisitingItem(checkedListItem: item,delete: true)//(id: itemId, delete: true)
        {
            starButton.tintColor = .gray
            if let item = listItem
            {
                itemsDelegate?.markAsNotFavourite(listItem: item,isfavourited: false)
                guard let homeController = homeController else {return}
                if homeController.favoriteMode
                {
                itemsDelegate?.deleteItem(dataItem: item)
                homeController.navigationController?.popViewController(animated: true)
                }
            }
        }
        else
        {
            UserDefaults.standard.favoriteItem(checkedListItem: item)
            itemsDelegate?.markAsNotFavourite(listItem: item, isfavourited: true)
            starButton.tintColor = .orange
        }
        }
    }
    func setupLayout()
    {
        let actualHeight = (frame.height - height!) / 2
        addSubview(itemImage)
        NSLayoutConstraint.activate([
            itemImage.topAnchor.constraint(equalTo: topAnchor),
            itemImage.leftAnchor.constraint(equalTo: leftAnchor),
            itemImage.rightAnchor.constraint(equalTo: rightAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: actualHeight)
            ])
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: itemImage.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: leftAnchor),
            containerView.rightAnchor.constraint(equalTo: rightAnchor),
            containerView.heightAnchor.constraint(equalToConstant: height ?? 100)
            ])
        containerView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant:-5),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant:50),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        containerView.addSubview(starButton)
        NSLayoutConstraint.activate([
            starButton.leftAnchor.constraint(equalTo: leftAnchor),
            starButton.heightAnchor.constraint(equalToConstant: 50),
            starButton.topAnchor.constraint(equalTo: titleLabel.topAnchor,constant: 15),
            starButton.widthAnchor.constraint(equalToConstant: 50)
            ])
        addSubview(socialContainer)
        NSLayoutConstraint.activate([
            socialContainer.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            socialContainer.leftAnchor.constraint(equalTo: leftAnchor),
            socialContainer.rightAnchor.constraint(equalTo: rightAnchor),
            socialContainer.heightAnchor.constraint(equalToConstant: actualHeight)
            ])
        socialContainer.addSubview(stackView)
        stackView.anchorWithConstantsToTop(top: socialContainer.topAnchor, left: socialContainer.leftAnchor, bottom: socialContainer.bottomAnchor, right: socialContainer.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5)
        stackView.backgroundColor = .green
        starButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(visitWebsite(sender:)), for: .touchUpInside)
    }
    
    @objc func visitWebsite(sender: UIButton)
    {
        var urlList:[String] = [String]()
        if let item = listItem
        {
            if let facebookLink = item.facebook_link
            {
                urlList = [facebookLink]
            }
            if let instagramLink = item.instagram_link
            {
                urlList.append(instagramLink)
            }
            if let appstoreLink = item.app_store_link
            {
                urlList.append(appstoreLink)
            }
            if let websiteLink = item.website_link
            {
                urlList.append(websiteLink)
            }
            if let youtubeLink = item.youtube_link
            {
                urlList.append(youtubeLink)
            }
            if let twitterLink = item.twitter_link
            {
                urlList.append(twitterLink)
            }
            
        }
        if let url = URL(string: urlList[sender.tag])
        {
            UIApplication.shared.open(url, options: [:])
        }
        else
        {
            print("not a url")
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
