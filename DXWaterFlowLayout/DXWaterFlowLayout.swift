//
//  DXWaterFlowLayout.swift
//  UICategories
//
//  Created by xiekw on 1/28/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit

protocol DXWaterFlowLayoutDelegate {
    func collectionView(collectionView: UICollectionView, layout: DXWaterFlowLayout, heightForItemAtIndexPath indexPath: NSIndexPath) -> CGFloat
}

class DXWaterFlowLayout: UICollectionViewLayout {
    
    var itemWidth: CGFloat! {
        willSet(newValue) {
            columnCount = Int(CGRectGetWidth(collectionView!.frame) / (newValue + minumInterItemSpacing))
            invalidateLayout()
        }
    }
    var sectionInset: UIEdgeInsets! {
        didSet {
            invalidateLayout()
        }
    }
    var minumInterItemSpacing: CGFloat!
    var lineSpacing: CGFloat!
    var waterFlowDelegate: DXWaterFlowLayoutDelegate!
    
    private var itemCount: Int!
    private var columnCount: Int!
    private var columnHeights: [CGFloat]!
    private var itemAttributes: [UICollectionViewLayoutAttributes]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    private func commonInit() {
        columnCount = 2
        sectionInset = UIEdgeInsetsZero
        minumInterItemSpacing = 0.0
        lineSpacing = 0.0
        itemCount = 0
        columnHeights = [CGFloat]()
        itemAttributes = [UICollectionViewLayoutAttributes]()
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        itemCount = collectionView!.numberOfItemsInSection(0)
        itemAttributes.removeAll(keepCapacity: true)
        columnHeights.removeAll(keepCapacity: true)
        
        for idx in 0..<columnCount{
            columnHeights.append(lineSpacing + sectionInset.top) 
        }
        
        for i in 0..<itemCount {
            let indexPath = NSIndexPath(forItem: i, inSection: 0)
            let cellHeight = waterFlowDelegate.collectionView(collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
            let shortestColumnIndex = shortestColumn()
            let cellOriginX = sectionInset.left + (itemWidth + minumInterItemSpacing) * CGFloat(shortestColumnIndex)
            let cellOriginY = columnHeights[shortestColumnIndex]
            let atrForIndexPath = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
            atrForIndexPath.frame = CGRect(origin: CGPointMake(cellOriginX, cellOriginY), size: CGSizeMake(itemWidth, cellHeight))
            itemAttributes.append(atrForIndexPath)
            columnHeights[shortestColumnIndex] = cellOriginY + cellHeight + lineSpacing
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        return itemAttributes.filter({ (atr) -> Bool in
            return CGRectIntersectsRect(rect, atr.frame)
        })
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        return itemAttributes[indexPath.item]
    }
    
    override func collectionViewContentSize() -> CGSize {
        if itemCount == 0 {
            return CGSizeZero
        }
        
        var size = collectionView!.bounds.size
        let shortIndex = longestColumn()
        let height = columnHeights[shortIndex]
        size.height = height - minumInterItemSpacing + sectionInset.bottom
        return size
    }
    
    private func shortestColumn() -> Int {
        var shortestHeight: CGFloat = CGFloat.max
        var shortestIndex: Int = 0
        for (index, value) in enumerate(columnHeights) {
            if shortestHeight > value {
                shortestHeight = value
                shortestIndex = index
            }
        }
        return shortestIndex
    }
    
    private func longestColumn() -> Int {
        var longest: CGFloat = -1.0
        var longestIndex: Int = 0
        for (index, value) in enumerate(columnHeights) {
            if value > longest {
                longest = value
                longestIndex = index
            }
        }
        return longestIndex
    }
}

