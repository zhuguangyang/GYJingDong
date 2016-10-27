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
    
    fileprivate var shopLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
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
                weakSelf?.productArray.append(contentsOf: productArr1)
                weakSelf?.collectionView?.reloadData()
                weakSelf?.collectionView?.mj_footer.endRefreshing()
            })
        })
    }
    
    fileprivate func instanceUI() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: shopLayout)
        shopLayout.minimumLineSpacing = 5
        shopLayout.minimumInteritemSpacing = 5
        //        shopLayout.footerReferenceSize = CGSizeZero
        shopLayout.itemSize = CGSize(width: (SCREEN_WIDTH - 5 )/2, height:  (SCREEN_WIDTH - 5 )/2)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(collectionView!)
        
        collectionView?.register(UINib(nibName: "FoundCell",bundle: Bundle.main), forCellWithReuseIdentifier: "FoundCell")
        collectionView?.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeadView")
    }
    
    fileprivate func setupUI() {
        let banner = GYBanner()
        let bannerView = banner.initWithFrame(CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 180)) { (index) in
            
        }
        banner.reloadGYBanner(bannerArray)
        collectionView?.addSubview(bannerView)
        
        let headView = ChildHeadView()
        headView.modelArr = btnArray
        headView.frame = CGRect(x: 0, y: bannerView.frame.maxY, width: SCREEN_WIDTH, height: (SCREEN_WIDTH/4) * 2)
        collectionView?.addSubview(headView)
    }
    
    //MARK: - 懒加载
}

extension FoundVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        LogOverride.printLog("productArray.count:" + "\(productArray.count)")
        return productArray.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoundCell", for: indexPath) as! FoundCell
        
        let progressIndicatorView = CircularLoaderView(frame: CGRect.zero)
        let model  = productArray[(indexPath as NSIndexPath).row]
        
        //        cell.iconImage.sd_setImageWithURL(NSURL(string: model.imageNamed), placeholderImage: UIImage(named: "default_CommentDetai_Big"))
        cell.iconImage.addSubview(progressIndicatorView)
        progressIndicatorView.frame = cell.iconImage.bounds
        progressIndicatorView.autoresizingMask = [.flexibleWidth,.flexibleHeight];
        cell.iconImage.sd_setImage(with: URL(string: model.imageNamed), placeholderImage: nil, options: .cacheMemoryOnly, progress: {(reseivdSize, expectedSize) -> Void in
            progressIndicatorView.progress = CGFloat(reseivdSize) / CGFloat(expectedSize)
            
        }) { (image, error, _, _) -> Void in
            progressIndicatorView.reveal()
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableview = UICollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeadView", for: indexPath)
            let banner = GYBanner()
            let bannerView = banner.initWithFrame(CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 180)) { (index) in
                
            }
            banner.reloadGYBanner(bannerArray)
            reusableview.addSubview(bannerView)
            
            let headView = ChildHeadView()
            headView.modelArr = btnArray
            headView.frame = CGRect(x: 0, y: bannerView.frame.maxY, width: SCREEN_WIDTH, height: (SCREEN_WIDTH/4) * 2)
            reusableview.addSubview(headView)
            heightHeadView = headView.frame.size.height + 180
        }
        
        return reusableview
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if heightHeadView != nil {
            LogOverride.printLog(heightHeadView)
            return CGSize(width: SCREEN_WIDTH, height: heightHeadView!)
        }
        return CGSize(width: SCREEN_WIDTH, height: 373)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = productArray[(indexPath as NSIndexPath).row]
        
        let detail = DetailViewController()
        detail.url = model.link
        detail.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detail, animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        weak var weakSelf = self
        if scrollView.contentOffset.y >= 20 {
            UIView.animate(withDuration: 0.5, animations: { 
                weakSelf?.navigationController?.navigationBar.isHidden = true
            })
        }
        if scrollView.contentOffset.y <= -20 {
            UIView.animate(withDuration: 0.5, animations: {
                weakSelf?.navigationController?.navigationBar.isHidden = false
            })
        }
        
    }
    
    
}
