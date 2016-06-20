//
//  FoundVC.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import MJRefresh

class FoundVC: GYBaseViewController {
    
    var collectionView:UICollectionView?
    ///保存轮播图
    var bannerArray:[GYBannerModel] = []
    var heightHeadView:CGFloat?
    
    /// 页数
    var pageCount:Int = 1
    var offsetCount: Int = 0
    var productArray:[GYBannerModel] = []
        {
        didSet {
            collectionView?.reloadData()
        }
    }
    /// 保存btn
    var btnArray: [GYBannerModel] = []
        {
        didSet{
            collectionView?.reloadData()
        }
    }
    
    private var shopLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceUI()
        //        setupUI()
        weak var weakSelf = self
        collectionView?.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            weakSelf?.bannerArray.removeAll()
            weakSelf?.btnArray.removeAll()
            weakSelf?.productArray.removeAll()
            weakSelf?.pageCount = 1
            weakSelf?.offsetCount = 0
            weakSelf?.getDatas()
        })
        collectionView?.mj_header.beginRefreshing()
        collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            weakSelf?.pageCount = (weakSelf?.pageCount)! + 1
            weakSelf?.offsetCount += 20
            weakSelf?.getFootDatas()
        })
    }
    /**
     获取下拉刷新的数据
     */
    private func getDatas() {
        weak var weakSelf = self
        GYNetWorking.defaultManager?.GET("V2Banner", paramas: ["f":"iphone","type":"faxian","v":"6.3.2","weixin":1], sucess: { (obj) in
            
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
            weakSelf?.collectionView?.mj_header.endRefreshing()
            }, failure: { (error) in
                print(error)
        })
        //http://api.smzdm.com/v1/faxian/articles?f=iphone&imgmode=0&limit=20&offset=0&page=1&v=6.3.2&weixin=1
        GYNetWorking.defaultManager?.GET("FaXian", paramas: ["f":"iphone","imgmode":"0","v":"6.3.2","weixin":1,"limit":20,"offset":offsetCount,"page":pageCount], sucess: { (obj) in
            print(obj)
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["article_pic"]! as? String ?? ""
                weakSelf?.productArray.append(model)
            }
            weakSelf?.collectionView?.mj_header.endRefreshing()
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    private func getFootDatas() {
        weak var weakSelf = self
        if pageCount == 3 {
            weakSelf?.collectionView?.mj_footer.resetNoMoreData()
            return
        }
        GYNetWorking.defaultManager?.GET("FaXian", paramas: ["f":"iphone","imgmode":"0","v":"6.3.2","weixin":1,"limit":20,"offset":offsetCount,"page":pageCount], sucess: { (obj) in
            print(obj)
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["article_pic"]! as? String ?? ""
                weakSelf?.productArray.append(model)
            }
            weakSelf?.collectionView?.reloadData()
            weakSelf?.collectionView?.mj_footer.endRefreshing()
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    private func instanceUI() {
        collectionView = UICollectionView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), collectionViewLayout: shopLayout)
        shopLayout.minimumLineSpacing = 5
        shopLayout.minimumInteritemSpacing = 5
        shopLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 5 )/2, height:  (SCREEN_WIDTH - 5 )/2)
        //        shopLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 300)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.backgroundColor = UIColor.groupTableViewBackgroundColor()
        view.addSubview(collectionView!)
        
        collectionView?.registerNib(UINib(nibName: "FoundCell",bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "FoundCell")
        collectionView?.registerClass(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadView")
    }
    
    private func setupUI() {
        let banner = GYBanner()
        let bannerView = banner.initWithFrame(CGRectMake(0, 0, SCREEN_WIDTH, 180)) { (index) in
            
        }
        banner.reloadGYBanner(bannerArray)
        collectionView?.addSubview(bannerView)
        
        let headView = ChildHeadView()
        headView.modelArr = btnArray
        headView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), SCREEN_WIDTH, (SCREEN_WIDTH/4) * 2)
        collectionView?.addSubview(headView)
    }
    
    //MARK: - 懒加载
}

extension FoundVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return productArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoundCell", forIndexPath: indexPath) as! FoundCell
        let model  = productArray[indexPath.row]
        
        cell.iconImage.sd_setImageWithURL(NSURL(string: model.imageNamed), placeholderImage: UIImage(named: "default_CommentDetai_Big"))
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            reusableview = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "HeadView", forIndexPath: indexPath)
            let banner = GYBanner()
            let bannerView = banner.initWithFrame(CGRectMake(0, 0, SCREEN_WIDTH, 180)) { (index) in
                
            }
            banner.reloadGYBanner(bannerArray)
            reusableview.addSubview(bannerView)
            
            let headView = ChildHeadView()
            headView.modelArr = btnArray
            headView.frame = CGRectMake(0, CGRectGetMaxY(bannerView.frame), SCREEN_WIDTH, (SCREEN_WIDTH/4) * 2)
            reusableview.addSubview(headView)
            heightHeadView = headView.frame.size.height + 180
        }
        
        return reusableview
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(SCREEN_WIDTH, 373)
    }
    
    
}
