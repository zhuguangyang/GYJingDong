//
//  FoundCell.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/16.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class FoundCell: UICollectionViewCell {
    // 创建一个实例对象  图片加载进度
    //    let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
    @IBOutlet weak var iconImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
}
