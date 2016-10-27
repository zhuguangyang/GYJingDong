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
            
            SDWebImageManager.shared().downloadImage(with: URL(string: (weakSelf?.imageArr[0].imageNamed)!), options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, error, _, _, _) in
                LogOverride.printLog(error)
                weakSelf?.tableView?.reloadData()
            })
            }, failure: { (error) in
                print(error)
        })
        
    }
    
    fileprivate func instanceUI() {
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.grouped)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        view.addSubview(tableView!)
    }
    
    
}

extension GoodThingVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.red
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if imageArr.count > 0 {
            let  model = imageArr[0]
            let key = URL(string: model.imageNamed)?.absoluteString
            LogOverride.printLog(key)
            let image = SDWebImageManager.shared().imageCache.imageFromDiskCache(forKey: key)
            LogOverride.printLog(image)
            let height = ( (image?.size.height)! / (image?.size.width)! ) * SCREEN_WIDTH
            LogOverride.printLog(image?.size)
            return height
        }
        return 0
    }
    
    
}
