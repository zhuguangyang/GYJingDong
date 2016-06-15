//
//  GYTabBarViewController.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/15.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit

class GYTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value =  giveMeVC("ValueBuyVC", vcTitle: "超值", vcItemTitle:  "超值流")
        let found = giveMeVC("FoundVC", vcTitle: "发现", vcItemTitle: "火眼金晶")
        let goodThing = giveMeVC("GoodThingVC", vcTitle: "好物", vcItemTitle: "不容错过")
        let me = giveMeVC("MeVC", vcTitle: "靓妹", vcItemTitle: "")
        
        viewControllers = [giveMeNavWithVc(value, imageName: "mainNormal", selectImagename: "mainSeleted"),giveMeNavWithVc(found, imageName: "dingyueItem", selectImagename: "dingyueItemSelected"),giveMeNavWithVc(goodThing, imageName: "dingyueItem", selectImagename: "dingyueItemSelected"),giveMeNavWithVc(me, imageName: "personNormal", selectImagename: "personSeleted")]
        
        tabBar.tintColor = UIColor.redColor()
    }
    
    /**
     通过字符串创建类
     
     - parameter vcName:      类名
     - parameter vcTitle:
     - parameter vcItemTitle:
     
     - returns: 
     */
    func giveMeVC(vcName: String,vcTitle: String,vcItemTitle: String) -> UIViewController {
        
        /// 命名空间
        let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let cls: AnyClass? = NSClassFromString(nameSpace + "." + vcName)
        
        //将AnyClass 转化为指定的类型
        let vcCls = cls as! UIViewController.Type
        //通过class创建对象
        let vc = vcCls.init()
        vc.title = vcTitle
        vc.navigationItem.title = vcItemTitle
        return vc
    }
    
    
    /**
     获取取消渲染的image
     - parameter imageName: 图片名称
     */
    func removeRendering(imageName:String) -> UIImage {
        let image = UIImage(named: imageName)
        
        return (image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal))!
    }
    
    /**
     创建UINavigationController
     
     - parameter vc:              vc
     - parameter imageName:       普通图片
     - parameter selectImagename: 点击锁定的图片
     
     - returns:
     */
    func giveMeNavWithVc(vc: UIViewController,imageName: String,selectImagename: String) -> UINavigationController{
        
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.translucent = true
        nav.navigationBar.backgroundColor = UIColor.redColor()
        //这个值需要自己在设置
        //设置背景颜色
        nav.navigationBar.setBackgroundImage(UIImage(named:"navi_zhi"), forBarMetrics: UIBarMetrics.Default)
        //UIImage(named: "Bg_user_float"),
        //        nav.navigationBar.setBackgroundImage(removeRendering("Bg_user_float"), forBarMetrics: UIBarMetrics.Default)
        //        let image = removeRendering("taBg_user")
        
        
        nav.navigationBar.barTintColor = UIColor.purpleColor()
        
        nav.tabBarItem = UITabBarItem.init(title: vc.tabBarItem.title, image: removeRendering(imageName), selectedImage: removeRendering(selectImagename))
        return nav
        
    }
    
    
}
