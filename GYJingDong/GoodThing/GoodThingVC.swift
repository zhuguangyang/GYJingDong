//
//  GoodThingVC.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import SDWebImage

class GoodThingVC: GYBaseViewController {
    
    var tableView: UITableView?
    var imageArr: [GYBannerModel] = []
        {
        didSet {
            tableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        instanceUI()
        weak var weakSelf = self
        GYNetWorking.defaultManager?.GET("HaoWu", paramas: ["f":"iphone","v":"6.3.2","weixin":1], sucess: { (obj) in
            let bannerA = obj["data"] as? [[String:AnyObject]]
            for item in bannerA!{
                
                let model = GYBannerModel()
                model.imageNamed = item["picture"]! as? String ?? ""
                weakSelf?.imageArr.append(model)
                
            }
            
            SDWebImageManager.sharedManager().downloadImageWithURL(NSURL(string: (weakSelf?.imageArr[0].imageNamed)!), options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, error, _, _, _) in
                LogOverride.printLog(error)
                weakSelf?.tableView?.reloadData()
            })
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    private func instanceUI() {
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Grouped)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.addSubview(tableView!)
    }
    
    
}

extension GoodThingVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.redColor()
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if imageArr.count > 0 {
            let  model = imageArr[0]
            let key = NSURL(string: model.imageNamed)?.absoluteString
            LogOverride.printLog(key)
            let image = SDWebImageManager.sharedManager().imageCache.imageFromDiskCacheForKey(key)
            LogOverride.printLog(image)
            let height = ( image.size.height / image.size.width ) * SCREEN_WIDTH
            LogOverride.printLog(image.size)
            return height
        }
        return 0
    }
    
    
}
