//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay

public protocol NSJsonSerial {
    associatedtype NSJson
    var nsjson:NSJson{get}
}
extension Array:NSJsonSerial{
    public typealias NSJson = NSMutableArray
    public var nsjson: NSJson{
        get{
            return self.mutable_array
        }
    }
}
extension Dictionary:NSJsonSerial{
    public typealias NSJson = NSMutableDictionary
    public var nsjson: NSJson{
        get{
            return self.mutable_dictionary
        }
    }
}
extension NSDictionary:NSJsonSerial{
    public typealias NSJson = NSMutableDictionary
    public var nsjson: NSJson{
        get{
            return self.mutable_dictionary
        }
    }
}

extension NSArray:NSJsonSerial{
    public typealias NSJson = NSMutableArray
    public var nsjson: NSJson{
        get{
            return self.mutable_array
        }
    }
}



extension NSMutableArray{
    public var swift_array:[[String:Any]]
    {
        get{
            var array = [[String:Any]]()
            for _value in self
            {
                if let d = _value as? [String:Any]{
                    array.append(d)
                }else if let d = _value as? NSMutableDictionary{
                }
            }
            return array
        }
    }
}

extension Array{
    public subscript(_ from:Int?,_ to:Int?) ->Array{
        var newList = [Element]()
        
        
        let f = from ?? 0
        let t = to ?? self.count
        for (i,obj) in self.enumerated()
        {
            if i >= f && i <= t
            {
                newList.append(obj)
            }
        }
        return newList
    }
}
let list = [["page":"12"],["page":"31"],["page":"34"],["page":"231"]].mutable_array
let ls = list.swift_array
let c = ls[0,1]
print(c)


//var text = ""
//let range = NSRange(location: 0, length: 0)
//let index = text.index(text.startIndex, offsetBy: range.location)
//text.insert(contentsOf: "GOS", at: index)
//print(text)

