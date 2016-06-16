//
//  FoundVC.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class FoundVC: GYBaseViewController {
    
    var collectionView:UICollectionView?
    ///保存轮播图
    var bannerArray:[GYBannerModel] = []
    /// 保存btn
    var btnArray: [GYBannerModel] = []
    
    private var shopLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instanceUI()
        //        setupUI()
        
        //f=iphone&type=faxian&v=6.3.2&weixin=1
        weak var weakSelf = self
        GYNetWorking.defaultManager?.GET("V2Banner", paramas: ["f":"iphone","type":"faxian","v":"6.3.2","weixin":1], sucess: { (obj) in
            print(obj["data"]!!["rows"]!)
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["img"]! as? String ?? ""
                weakSelf?.bannerArray.append(model)
            }
            for item in  (obj["data"]!!["little_banner"]! as? [[String:AnyObject]])!{
                let model = GYBannerModel()
                model.imageNamed = item["img"]! as? String ?? ""
                model.labelText = (item["title"] ?? "") as! String
                weakSelf?.btnArray.append(model)
            }
            weakSelf?.setupUI()
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    
    private func instanceUI() {
        collectionView = UICollectionView(frame: CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT), collectionViewLayout: shopLayout)
        shopLayout.minimumLineSpacing = 5
        shopLayout.minimumInteritemSpacing = 5
        shopLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 5 )/2, height:  (SCREEN_WIDTH - 5 )/2)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        view.addSubview(collectionView!)
        
        collectionView?.registerNib(UINib(nibName: "FoundCell",bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "FoundCell")
    }
    
    private func setupUI() {
        let banner = GYBanner()
        let bannerView = banner.initWithFrame(CGRectMake(0, 64, SCREEN_WIDTH, 180)) { (index) in
            
        }
        for item in bannerArray {
            print(item.imageNamed)
        }
        banner.reloadGYBanner(bannerArray)
        //        view.addSubview(bannerView)
        collectionView?.addSubview(bannerView)
        
        let headView = ChildHeadView()
        headView.modelArr = btnArray
        headView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), SCREEN_WIDTH, SCREEN_WIDTH * 2)
        //        view.addSubview(headView)
        collectionView?.addSubview(headView)
    }
    
}

extension FoundVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoundCell", forIndexPath: indexPath) as! FoundCell
        cell.backgroundColor = UIColor.redColor()
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "", forIndexPath: indexPath)
        
        return reusableview
        
    }
    
}
