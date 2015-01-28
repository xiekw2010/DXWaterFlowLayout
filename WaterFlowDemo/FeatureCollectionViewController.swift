//
//  FeatureCollectionViewController.swift
//  WaterFlowDemo
//
//  Created by xiekw on 1/28/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit


class FeatureCollectionViewController: UICollectionViewController, DXWaterFlowLayoutDelegate {

    var photos: [DXPhoto]!
    let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photos = DXPhoto.photos()

        let waterLayout = DXWaterFlowLayout()
        collectionView!.collectionViewLayout = waterLayout
        collectionView!.backgroundColor = UIColor.whiteColor()
        waterLayout.itemWidth = CGRectGetWidth(collectionView!.frame) * 0.3
        waterLayout.sectionInset = UIEdgeInsetsMake(10.0, 5.0, 5.0, 5.0)
        waterLayout.minumInterItemSpacing = 10.0
        waterLayout.lineSpacing = 10.0
        waterLayout.waterFlowDelegate = self
        
        collectionView!.registerClass(WaterFlowCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    func collectionView(collectionView: UICollectionView, layout: DXWaterFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let photo = photos[indexPath.item]
        let cellWidth = collectionView.collectionViewLayout as DXWaterFlowLayout
        let result = WaterFlowCellSuggestHeight(photo.display, photo.photoDescription, cellWidth.itemWidth)
        return result
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as WaterFlowCollectionViewCell
        
        cell.photo = photos[indexPath.item]
        return cell
    }
}
