//
//  SectionItems.swift
//  skeletonProject
//
//  Created by Sherif  Wagih on 9/2/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
class SectionItems: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.backgroundColor = .lightGray
        loadData()
    }
    func loadData()
    {
        print("loading Countries")
    }
    let cellId = "cellId"
    @IBAction func goBackToSections(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.height / 6)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        cell.backgroundColor = .white
        cell.titleLabel.text = "لعبة جميلة جدا Swat"
        cell.subTitleLabel.text = "لعبة الاسطورة Ostora"
        return cell
    }
}
