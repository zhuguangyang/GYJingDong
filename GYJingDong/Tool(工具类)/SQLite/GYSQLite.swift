//
//  GYSQLite.swift
//  GYJingDong
//
//  Created by zhuguangyang on 16/6/21.
//  Copyright © 2016年 Giant. All rights reserved.
//

import UIKit
import SQLite

class GYSQLite: NSObject {
    
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let name = Expression<String?>("name")
    
    /// 创建数据库单利
    class var sharedInstance: GYSQLite {
        struct Static {
            static let instance = GYSQLite()
        }
        return Static.instance
    }
    
    /**
     创建用户数据库
     */
    func createSQLite() {
        
        //创建表  ifNotExists如果不存在才会创建 无此条件 若表已存在 就会崩溃
        try! db.run(users.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(email, unique: true)
            t.column(name)
            })
    }
    
    /**
     查找所有数据
     */
    func findAll() {
        for user in try! db.prepare(users) {
            print("id: \(user[id]), email: \(user[email]), name: \(user[name])")
        }
    }
    /**
     根据特定条件查找数据
     
     - parameter named: 特定条件
     */
    func findSpecialDB(named: String) {
        //        let stmt = try! db.prepare()
        // 设置条件
        let alice = users.filter(name == named)
        for user in try! db.prepare(alice) {
            print("id: \(user[id]), email: \(user[email]), name: \(user[name])")
        }
    }
    
    /**
     插入数据
     - parameter emaile:字段
     - parameter named:字段
     */
    func insertDB(emaile: String,named: String) {
        do {
            let rowID = try db.run(users.insert(email <- emaile,name <- named))
            LogOverride.printLog(rowID)
        } catch {
            LogOverride.printLog(error)
        }
        
    }
    
    /**
     删除全部数据
     */
    func deleteDBAll() {
        do {
            try db.run(users.delete())
        } catch {
            LogOverride.printLog(error)
        }
    }
    
    /**
     删除特定数据
     */
    func deleteSpecificDB(named: String) {
        do {
            //更新全部
            //            try db.run(users.update(name <- "DWYDA"))
            //            try db.run(users.dropIndex([id <- 1], ifExists: true))
            let alice = users.filter(name == named)
            try db.run(alice.delete())
        } catch {
            LogOverride.printLog(error)
        }
    }
    
    /**
     更新特定条件的数据
     - parameter named: 需要查找的名字
     */
    func updateSpecialDB(named: String) {
        let alice = users.filter(name == named)
        do {
            let user =  try db.run(alice.update(email <- "zhu@163.com"))
            LogOverride.printLog(user)
        } catch {
            LogOverride.printLog(error)
        }
    }
    
    /// 创建数据库操作柄
    private lazy var db: Connection = {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
        LogOverride.printLog(path)
        /**
         *  如果路径不存在就创建
         *
         *  @param path 路径
         *  @param true
         *  @param nil
         */
        let db = try? Connection("\(path)/GYdb.sqlite3")
        return db!
    }()
    
    /// 创建表
    private lazy var users: Table = {
        let users = Table("users")
        return users
    }()
    
}
