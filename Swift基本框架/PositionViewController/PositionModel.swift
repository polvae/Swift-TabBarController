//
//  PositionModel.swift
//  请求类
//
//  Created by KingSoft on 2017/7/5.
//  Copyright © 2017年 KingSoft. All rights reserved.
//

import UIKit

class PositionModel: NSObject {
    var qyid:String?    //146671",
    var fbrq:String?    //2017-05-27",
    var gzdd:String?    //长沙市-芙蓉区",
    var Zwid:String?    //1177623",
    var Yx:String?    //7000-8000",
    var qymc:String?    //小米科技",
    var zwmc:String?    //iOS程序员"
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}
