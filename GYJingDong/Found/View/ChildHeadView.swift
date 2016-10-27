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
    
    fileprivate var btnLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init(){
        super.init(frame: CGRect.zero, collectionViewLayout: btnLayout)
        
        //1.注册cell
        register(ChileHeadViewCell.self, forCellWithReuseIdentifier: "ChileHeadViewCell")
        //2.设置数据源
        dataSource = self
        delegate = self
        
        //2.设置cell之间的间隙
        btnLayout.minimumInteritemSpacing = 1
        btnLayout.minimumLineSpacing = 1
        btnLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 3) / 4, height: (SCREEN_WIDTH - 3)/4)
        backgroundColor = UIColor.white
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate class ChileHeadViewCell: UICollectionViewCell {
        
        override init(frame:CGRect) {
            super.init(frame: frame)
            
            //初始化UI
            setupUI()
        }
        
        
        fileprivate func setupUI() {
            
            //1.添加子控件
            contentView.addSubview(iconImageView)
            contentView.addSubview(iconLabel)
            iconLabel.textAlignment = .center
            //            iconLabel.font = UIFont.systemFontOfSize(15)
            //            iconLabel.sizeToFit()
            iconLabel.adjustsFontSizeToFitWidth = true
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
        fileprivate lazy var iconImageView:UIImageView = UIImageView()
        
        /// 图片标题
        fileprivate lazy var iconLabel: UILabel = UILabel()
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelArr.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChileHeadViewCell", for: indexPath) as! ChileHeadViewCell
        let model = modelArr[(indexPath as NSIndexPath).row]
        cell.iconImageView.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: UIImage(named: "default_faxian_bannerButton"))
        cell.iconLabel.text = model.labelText
        return cell
        
    }
    
}
