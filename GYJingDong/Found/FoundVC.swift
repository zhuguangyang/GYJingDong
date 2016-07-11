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
    
    let foundViewModel = FoundViewModel()
    
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
            weakSelf?.foundViewModel.getDatas({ (bannerArr1) in
                weakSelf?.bannerArray = bannerArr1
                weakSelf?.collectionView?.mj_header.endRefreshing()
                }, btnBlock: { (btnArr1) in
                    weakSelf?.btnArray = btnArr1
                    weakSelf?.collectionView?.mj_header.endRefreshing()
                },productBlock: {(productArr1) in
                    weakSelf?.productArray = productArr1
                    weakSelf?.collectionView?.mj_header.endRefreshing()
            })
        })
        collectionView?.mj_header.beginRefreshing()
        collectionView?.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            weakSelf?.pageCount = (weakSelf?.pageCount)! + 1
            weakSelf?.offsetCount += 20
            weakSelf?.foundViewModel.getFootDatas((weakSelf?.offsetCount)!, pageCount: (weakSelf?.pageCount)!, productBlock: { (productArr1) in
                weakSelf?.productArray.appendContentsOf(productArr1)
                weakSelf?.collectionView?.reloadData()
                weakSelf?.collectionView?.mj_footer.endRefreshing()
            })
        })
    }
    
    private func instanceUI() {
        collectionView = UICollectionView(frame: CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT), collectionViewLayout: shopLayout)
        shopLayout.minimumLineSpacing = 5
        shopLayout.minimumInteritemSpacing = 5
        //        shopLayout.footerReferenceSize = CGSizeZero
        shopLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 5 )/2, height:  (SCREEN_WIDTH - 5 )/2)
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
        //        LogOverride.printLog("productArray.count:" + "\(productArray.count)")
        return productArray.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FoundCell", forIndexPath: indexPath) as! FoundCell
        
        let progressIndicatorView = CircularLoaderView(frame: CGRectZero)
        let model  = productArray[indexPath.row]
        
        //        cell.iconImage.sd_setImageWithURL(NSURL(string: model.imageNamed), placeholderImage: UIImage(named: "default_CommentDetai_Big"))
        cell.iconImage.addSubview(progressIndicatorView)
        progressIndicatorView.frame = cell.iconImage.bounds
        progressIndicatorView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight];
        cell.iconImage.sd_setImageWithURL(NSURL(string: model.imageNamed), placeholderImage: nil, options: .CacheMemoryOnly, progress: {(reseivdSize, expectedSize) -> Void in
            progressIndicatorView.progress = CGFloat(reseivdSize) / CGFloat(expectedSize)
            
        }) { (image, error, _, _) -> Void in
            progressIndicatorView.reveal()
        }
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
        if heightHeadView != nil {
            LogOverride.printLog(heightHeadView)
            return CGSizeMake(SCREEN_WIDTH, heightHeadView!)
        }
        return CGSizeMake(SCREEN_WIDTH, 373)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let model = productArray[indexPath.row]
        
        let detail = DetailViewController()
        detail.url = model.link
        detail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        weak var weakSelf = self
        if scrollView.contentOffset.y >= 20 {
            UIView.animateWithDuration(0.5, animations: { 
                weakSelf?.navigationController?.navigationBar.hidden = true
            })
        }
        if scrollView.contentOffset.y <= -20 {
            UIView.animateWithDuration(0.5, animations: {
                weakSelf?.navigationController?.navigationBar.hidden = false
            })
        }
        
    }
    
    
}
