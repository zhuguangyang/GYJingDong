//
//  GYBaseViewController.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class GYBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    /**
     创建左边的按钮
     
     - parameter title:  名称
     - parameter target: 响应者
     - parameter action: 响应事件
     */
    func creatLeftBarBtn(title: String?, target: AnyObject?, action: Selector) {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: target, action: action)
    }
    
    /**
     创建右边的按钮
     
     - parameter title:  名称
     - parameter target: 响应者
     - parameter action: 响应事件
     */
    func creatRightBarBtn(title: String?, target: AnyObject?, action: Selector) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: target, action: action)
    }
    
    /**
     创建右边的按钮(带图片 待微调)
     
     - parameter title:  名称
     - parameter target: 响应者
     - parameter action: 响应事件
     */
    func creatRightBarBtn(title: String?,imageName: String?, target: AnyObject?, action: Selector) {
        
        let btn = UIButton()
        if title != "" {
            btn.setTitle(title, forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        if imageName != "" {
            btn.setImage(UIImage(named: imageName!), forState: UIControlState.Normal)
        }
        
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    /**
     创建左边的按钮(带图片)
     
     - parameter title:  名称
     - parameter target: 响应者
     - parameter action: 响应事件
     */
    func creatLeftBarBtn(title: String?,imageName: String?, target: AnyObject?, action: Selector) {
        
        let btn = UIButton()
        if imageName != "" {
            btn.setImage(removeRendering(imageName!), forState: UIControlState.Normal)
        }
        if title != "" {
            btn.setTitle(title, forState: UIControlState.Normal)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    /**
     获取取消渲染的image
     - parameter imageName: 图片名称
     */
    func removeRendering(imageName:String) -> UIImage {
        let image = UIImage(named: imageName)
        
        return (image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))!
    }
    
  
}
