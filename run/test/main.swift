//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay

public protocol NSJsonObj {
    func jsonObj<T>() -> T?
}


public protocol NSJsonSerial:NSJsonObj{
    associatedtype NSJson
    var nsjson:NSJson{get}
}
extension Array:NSJsonSerial{
  
    
    public func jsonObj<T>() -> T? {
        return nsjson as? T
    }
    
    public typealias NSJson = NSMutableArray
    public var nsjson: NSJson{
        get{
            return self.mutable_array
        }
    }
}
extension Dictionary:NSJsonSerial{
    
    public func jsonObj<T>() -> T? {
        return nsjson as? T
    }
    public typealias NSJson = NSMutableDictionary
    public var nsjson: NSJson{
        get{
            return self.mutable_dictionary
        }
    }
}
extension NSDictionary:NSJsonSerial{
    
    public func jsonObj<T>() -> T? {
        return nsjson as? T
    }
    public typealias NSJson = NSMutableDictionary
    public var nsjson: NSJson{
        get{
            return self.mutable_dictionary
        }
    }
}

extension NSArray:NSJsonSerial{
    
    public func jsonObj<T>() -> T? {
        return nsjson as? T
    }
    public typealias NSJson = NSMutableArray
    public var nsjson: NSJson{
        get{
            return self.mutable_array
        }
    }
}


let a:Any = ["23","sa"]
if let c = a as? NSJsonObj{
    let o:NSMutableDictionary? = c.jsonObj()
    print(o as Any)
}

