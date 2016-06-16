//
//  ChildHeadView.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/16.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import SnapKit

class ChildHeadView: UICollectionView {
    
    var modelArr: [GYBannerModel] = []
        {
        didSet{
            reloadData()
        }
    }
    
    private var btnLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(){
        super.init(frame: CGRectZero, collectionViewLayout: btnLayout)
        
        //1.注册cell
        registerClass(ChileHeadViewCell.self, forCellWithReuseIdentifier: "ChileHeadViewCell")
        //2.设置数据源
        dataSource = self
        delegate = self
        
        //2.设置cell之间的间隙
        btnLayout.minimumInteritemSpacing = 1
        btnLayout.minimumLineSpacing = 1
        btnLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 3) / 4, (SCREEN_WIDTH - 3)/4)
        backgroundColor = UIColor.whiteColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private class ChileHeadViewCell: UICollectionViewCell {
        
        override init(frame:CGRect) {
            super.init(frame: frame)
            
            //初始化UI
            setupUI()
        }
        
        
        private func setupUI() {
            
            //1.添加子控件
            contentView.addSubview(iconImageView)
            contentView.addSubview(iconLabel)
            iconLabel.textAlignment = .Center
            iconLabel.sizeToFit()
            //2.布局子空间
            iconImageView.snp_makeConstraints { (make) in
                make.top.equalTo(contentView).offset(8)
                make.left.equalTo(contentView).offset(20)
                make.right.equalTo(contentView).offset(-20)
                make.height.equalTo(iconImageView.snp_width)
            }
            iconLabel.snp_makeConstraints { (make) in
                make.bottom.equalTo(contentView).offset(-10)
                //                make.top.height.equalTo(16)
                make.left.equalTo(contentView)
                make.right.equalTo(contentView)
            }
            
        }
        
        //MARK: - 懒加载
        /// 懒加载 图片
        private lazy var iconImageView:UIImageView = UIImageView()
        
        /// 图片标题
        private lazy var iconLabel: UILabel = UILabel()
        
        //        private lazy var btn: UIButton = {
        //            let btn = UIButton()
        //            btn.backgroundColor = UIColor.redColor()
        //            btn.sizeToFit()
        //            return btn
        //        }()
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}

extension ChildHeadView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChileHeadViewCell", forIndexPath: indexPath) as! ChileHeadViewCell
        let model = modelArr[indexPath.row]
        cell.iconImageView.sd_setImageWithURL(NSURL(string: model.imageNamed), placeholderImage: UIImage(named: "search_d"))
        cell.iconLabel.text = model.labelText
        return cell
        
    }
    
}
