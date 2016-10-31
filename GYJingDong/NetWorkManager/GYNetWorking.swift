//
//  GYNetWorking.swift
//  Alamofire3.0封装
//
//  Created by zhuguangyang on 16/6/14.
//  Copyright © 2016年 Giant. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class GYNetWorking: NSObject {
    
    required  init?(NetWorkParmas: NSDictionary) {
        self.NetWorkParmas = NetWorkParmas
        super.init()
    }
    
    /**获取单利*/
    static var defaultManager = GYNetWorking(NetWorkParmas: NSDictionary(contentsOfFile: Bundle.main.path(forResource: "NetWorkPlist", ofType: "plist")!)!)
    
    /**
     GET请求
     
     - parameter pathKey: 路径
     - parameter paramas: 参数
     - parameter sucess:  成功回调
     - parameter failure: 失败回调
     */
    func GET(_ pathKey: String,paramas: NSDictionary?,sucess:((AnyObject) -> Void)?,failure:((NSError) -> Void)?) {
        let url = webRoot + path[pathKey]!
        print("url" + "\(url)")   
        //3.0 swift 2.3
//        Alamofire.request(.GET, url, parameters: paramas as? [String : AnyObject], encoding: .URL, headers: nil).responseJSON { (obj) in
//            switch obj.result {
//            case .Success(let value):
//                //                print(value)
//                sucess?(value)
//            case .Failure(let error):
//                failure?(error)
//            }
//        }
        //4.0 swift3
        request(url, method: .get, parameters: paramas as! Parameters?, encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                
                sucess?(value as AnyObject)
            case .failure(let error):
                failure?(error as NSError)
            }
        }
     
        
    }
    
    /**
     POST请求
     
     - parameter pathKey: 路径
     - parameter paramas: 参数
     - parameter sucess:  成功回调
     - parameter failure: 失败回调
     */
    func POST(_ pathKey: String,paramas: NSDictionary?,sucess:((AnyObject) -> Void)?,failure:((NSError) -> Void)?) {
        let url = webRoot + path[pathKey]!
        //3.0 swift 2.3
//        Alamofire.request(.POST, url, parameters: paramas as? [String : AnyObject], encoding: .URL, headers: nil).responseJSON { (obj) in
//            switch obj.result {
//            case .Success(let value):
//                sucess?(value)
//            case .Failure(let error):
//                failure?(error)
//            }
//        }
        //4.0 swift3
        request(url, method: .post, parameters: paramas as! Parameters?, encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            switch data.result {
            case .success(let value):
                
                sucess?(value as AnyObject)
            case .failure(let error):
                failure?(error as NSError)
            }
        }
    }
    
    fileprivate let NetWorkParmas: NSDictionary
    
    /// 接口前缀
    var webRoot: String {
        return NetWorkParmas["WebRoot"] as! String
    }
    
    /// 接口后缀路径
    var path:[String : String] {
        return NetWorkParmas["Path"] as! [String : String]
    }
}
