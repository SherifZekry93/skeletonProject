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
    
    func loadData(id:Int,delete:Bool) -> Bool
    {
        let request:NSFetchRequest<DataListItem> = DataListItem.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@",NSNumber(value : id))
        let fetchedMessage = try? context.fetch(request)
        guard let messageId = fetchedMessage?.first?.id else {return false}
        if id == Int(messageId)
        {
            if delete
            {
                if let item = fetchedMessage?.first
                {
                    context.delete(item)
                }
            }
            return true
        }
        else
        {
            return false
        }
    }
    
    var height:CGFloat?{
        didSet{
            setupLayout()
        }
    }
  
    var listItem:ListItem?{
        didSet{
            
            if let title = listItem?.title
            {
                let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
                guard let subTitle = listItem?.details else {return }
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
            if let id = listItem?.id
            {
                if loadData(id: id, delete: false)
                {
                    starButton.tintColor = .orange
                }
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
    @objc func addToFavourite()
    {
        guard let id = listItem?.id else {return}
        if loadData(id: id, delete: true)
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
         //   UIAlertController.showAlert(message: "Make sure you have enough space!")
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
        
        starButton.addTarget(self, action: #selector(addToFavourite), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
