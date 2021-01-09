//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay


let a:Any = ["23","sa"]
if let c = a as? NSJsonObj{
    let o:NSMutableArray? = c.jsonObj()
    print(o as Any)
}

