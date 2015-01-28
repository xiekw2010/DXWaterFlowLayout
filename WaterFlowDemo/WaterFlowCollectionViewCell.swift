//
//  WaterFlowCollectionViewCell.swift
//  UICategories
//
//  Created by xiekw on 1/28/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit

let textAtr: NSDictionary = [NSFontAttributeName: UIFont.systemFontOfSize(16.0)]
let imageY: CGFloat = 5.0
let betweenImageAndLabel: CGFloat = 3.0
let bottomOffset: CGFloat = 5.0

func WaterFlowCellSuggestHeight(image: UIImage, text: String, constrainedWidth: CGFloat) -> CGFloat {
    
    var imageSize = image.size
    let imageSizeRatio = (constrainedWidth / imageSize.width)
    imageSize = CGSizeMake(constrainedWidth, imageSize.height * imageSizeRatio)
    let nsText = text as NSString
    let textSize = nsText.boundingRectWithSize(CGSizeMake(constrainedWidth, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textAtr, context: nil).size
    let result = imageY + imageSize.height + betweenImageAndLabel + textSize.height + bottomOffset
    
    return result
}

class WaterFlowCollectionViewCell: UICollectionViewCell {
    
    var textLabel: UILabel!
    var imageView: UIImageView!
    var photo: DXPhoto! {
        willSet(newValue) {
            imageView.image = newValue.display
            textLabel.text = newValue.photoDescription
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        imageView = UIImageView(frame: bounds)
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        textLabel = UILabel(frame: bounds)
        textLabel.numberOfLines = 0
        textLabel.font = textAtr[NSFontAttributeName] as UIFont
        textLabel.backgroundColor = UIColor.redColor()
        addSubview(imageView)
        addSubview(textLabel)
        backgroundColor = UIColor.grayColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutMyViews()
    }
    
    func layoutMyViews() {
        let selfSize = bounds.size
        let nsText = photo.photoDescription as NSString
        let textSize = nsText.boundingRectWithSize(CGSizeMake(selfSize.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textAtr, context: nil).size
        var imageSize = photo.display.size
        let imageSizeRatio = (selfSize.width / imageSize.width)
        imageSize = CGSizeMake(selfSize.width, imageSize.height * imageSizeRatio)
        imageView.frame = CGRectMake(0, imageY, imageSize.width, imageSize.height)
        textLabel.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame) + betweenImageAndLabel, selfSize.width, textSize.height)
    }
    
}

