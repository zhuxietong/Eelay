//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay

print("SLLS")
extension NSMutableDictionary{
    @discardableResult
    @objc public func combine(_ obj:NSMutableDictionary)->NSMutableDictionary {
        let ks = obj.allKeys.map{"\($0)"}
        for k in ks {
            if let value = obj.object(forKey: k)
            {
                self[k] = value
            }
        }
        return self
    }
}

//let ob = ["name":"gos","page":12].mutable_dictionary
//ob.combine(["name":"laozhu"]).combine(["name":"a3"]).combine(["page":"32"])
//
//print(ob)
