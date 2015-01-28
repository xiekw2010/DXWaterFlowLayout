//
//  DXPhoto.swift
//  WaterFlowDemo
//
//  Created by xiekw on 1/28/15.
//  Copyright (c) 2015 xiekw. All rights reserved.
//

import UIKit

class DXPhoto: NSObject {
   
    var thumbnail: UIImage!
    var display: UIImage!
    var photoDescription: String!
    
    class func photos() -> [DXPhoto] {
        var photos = [DXPhoto]()
        var token: dispatch_once_t = 0
        dispatch_once(&token) {
            let texts = [
                "In a storyboard-based application, you will often want jkdlajfl;jk;adjfl;",
                "override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section",
                "let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell",
                "override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject",
                "override func numberOfSectionsInCollectionView"
            ]
            
            let imageURLs = NSBundle.mainBundle().URLsForResourcesWithExtension("jpg", subdirectory: "DemoImages") as [NSURL]
            if imageURLs.count > 0 {
                for url in imageURLs {
                    let image = UIImage(contentsOfFile: url.path!)
                    let photo = DXPhoto()
                    photo.display = image
                    photo.photoDescription = texts[Int(arc4random() % UInt32(texts.count))]
                    photos.append(photo)
                }
            }
        }
        return photos
    }
}
