//
//  FoundHeadView.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/16.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class FoundHeadView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    private func setupUI() {
        
        
        //        addSubview(ChildHeadView)
        
    }
    
    
    lazy var childHeadView:ChildHeadView = ChildHeadView()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
