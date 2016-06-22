//
//  FoundViewModel.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/20.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class FoundViewModel: ViewModelClass {
    
    ///保存轮播图
    var bannerArray:[GYBannerModel] = []
    var heightHeadView:CGFloat?
    var productArray:[GYBannerModel] = []
    /// 保存btn
    var btnArray: [GYBannerModel] = []
    
    /**
     获取下拉刷新的数据 返回数据给VC使用
     */
    func getDatas(bannerBlock:((bannerArr1: [GYBannerModel]) -> Void),btnBlock:((btnArr1: [GYBannerModel]) -> Void),productBlock:((productArr1: [GYBannerModel]) -> Void))  {
        weak var weakSelf = self
        bannerArray.removeAll()
        btnArray.removeAll()
        productArray.removeAll()
        GYNetWorking.defaultManager?.GET("V2Banner", paramas: ["f":"iphone","type":"faxian","v":"6.3.2","weixin":1], sucess: { (obj) in
            
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["img"]! as? String ?? ""
                weakSelf?.bannerArray.append(model)
            }
            bannerBlock(bannerArr1: (weakSelf?.bannerArray)!)
            for item in  (obj["data"]!!["little_banner"]! as? [[String:AnyObject]])!{
                let model = GYBannerModel()
                model.imageNamed = item["img"]! as? String ?? ""
                model.labelText = (item["title"] ?? "") as! String
                weakSelf?.btnArray.append(model)
            }
            btnBlock(btnArr1: (weakSelf?.btnArray)!)
            }, failure: { (error) in
                print(error)
        })
        //http://api.smzdm.com/v1/faxian/articles?f=iphone&imgmode=0&limit=20&offset=0&page=1&v=6.3.2&weixin=1
        GYNetWorking.defaultManager?.GET("FaXian", paramas: ["f":"iphone","imgmode":"0","v":"6.3.2","weixin":1,"limit":20,"offset":0,"page":1], sucess: { (obj) in
            print(obj)
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["article_pic"]! as? String ?? ""
                model.link = item["article_url"]! as? String ?? ""
                weakSelf?.productArray.append(model)
            }
            productBlock(productArr1: (weakSelf?.productArray)!)
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    func getFootDatas(offsetCount: Int,pageCount: Int,productBlock:((productArr1: [GYBannerModel]) -> Void)) {
        weak var weakSelf = self
        GYNetWorking.defaultManager?.GET("FaXian", paramas: ["f":"iphone","imgmode":"0","v":"6.3.2","weixin":1,"limit":20,"offset":offsetCount,"page":pageCount], sucess: { (obj) in
            let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
            for item in bannerA!{
                let model = GYBannerModel()
                model.imageNamed = item["article_pic"]! as? String ?? ""
                model.link = item["article_url"]! as? String ?? ""
                weakSelf?.productArray.append(model)
            }
            productBlock(productArr1: (weakSelf?.productArray)!)
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    
    /* 原VC中数据请求
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
     model.link = item["article_url"]! as? String ?? ""
     weakSelf?.productArray.append(model)
     }
     weakSelf?.collectionView?.mj_header.endRefreshing()
     }, failure: { (error) in
     print(error)
     })
     
     }
     
     private func getFootDatas() {
     weak var weakSelf = self
     if pageCount == 300 {
     weakSelf?.collectionView?.mj_footer.endRefreshingWithNoMoreData()
     return
     }
     GYNetWorking.defaultManager?.GET("FaXian", paramas: ["f":"iphone","imgmode":"0","v":"6.3.2","weixin":1,"limit":20,"offset":offsetCount,"page":pageCount], sucess: { (obj) in
     let bannerA = obj["data"]!!["rows"]! as? [[String:AnyObject]]
     for item in bannerA!{
     let model = GYBannerModel()
     model.imageNamed = item["article_pic"]! as? String ?? ""
     model.link = item["article_url"]! as? String ?? ""
     weakSelf?.productArray.append(model)
     }
     weakSelf?.collectionView?.reloadData()
     weakSelf?.collectionView?.mj_footer.endRefreshing()
     }, failure: { (error) in
     print(error)
     })
     
     }
     */
    
}

