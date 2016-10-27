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
        
        viewControllers = [giveMeNavWithVc(value, imageName: "mainNormal", selectImagename: "mainSeleted"),giveMeNavWithVc(found, imageName: "goodsNormal", selectImagename: "goodsseleted"),giveMeNavWithVc(goodThing, imageName: "dingyueItem", selectImagename: "dingyueItemSelected"),giveMeNavWithVc(me, imageName: "personNormal", selectImagename: "personSeleted")]
        
        tabBar.tintColor = UIColor.red
    }
    
    /**
     通过字符串创建类
     
     - parameter vcName:      类名
     - parameter vcTitle:
     - parameter vcItemTitle:
     
     - returns: 
     */
    func giveMeVC(_ vcName: String,vcTitle: String,vcItemTitle: String) -> UIViewController {
        
        /// 命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
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
    func removeRendering(_ imageName:String) -> UIImage {
        let image = UIImage(named: imageName)
        
        return (image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))!
    }
    
    /**
     创建UINavigationController
     
     - parameter vc:              vc
     - parameter imageName:       普通图片
     - parameter selectImagename: 点击锁定的图片
     
     - returns:
     */
    func giveMeNavWithVc(_ vc: UIViewController,imageName: String,selectImagename: String) -> UINavigationController{
        
        //        if vc .isKindOfClass(MeVC) {}
        let nav = UINavigationController(rootViewController: vc)
        //        nav.navigationBar.translucent = true
        //这个值需要自己在设置
        //设置背景图片 241 77 74
        nav.navigationBar.setBackgroundImage(UIImage(named:"navi_zhi"), for: UIBarMetrics.default)
        //根据图层关系设置背景图片也可解决 背景颜色差20高度的问题
        //        let image = UIImageView(image: UIImage(named: "navi_zhi"))
        //        image.frame = nav.navigationBar.bounds
        //        nav.navigationBar.insertSubview(image, atIndex: 1)
        //        nav.navigationBar.backgroundColor = UIColor(red: 241/255.0, green: 77/255.0, blue: 74/255.0, alpha: 1.0)
        // 设置背景颜色缺失20  补足背景颜色
        let statusView = UIView(frame: CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width,height: 20))
        statusView.backgroundColor = UIColor(red: 241/255.0, green: 90/255.0, blue: 89/255.0, alpha: 1.0)
        view.addSubview(statusView)
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        nav.navigationBar.backgroundColor = UIColor(red: 241/255.0, green: 90/255.0, blue: 89/255.0, alpha: 1.0)
        
        nav.tabBarItem = UITabBarItem.init(title: vc.tabBarItem.title, image: removeRendering(imageName), selectedImage: removeRendering(selectImagename))
        return nav
        
    }
    /**
     颜色生成图片
     
     - parameter color: CGColor
     
     - returns: 图片
     */
    func createImageWithColor(_ color:UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
    
    
}
