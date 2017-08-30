//
//  PicCollectionViewCell.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/29.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

class PicCollectionViewCell: UICollectionViewCell {
    var imageView : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
