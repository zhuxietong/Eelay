//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay

let a = ["name":"1695663.1448"].mutable_dictionary
print(a[float:"name",0])
extension CGFloat{
    func digitalStr(num:Int=2)->String{
        let formatter = NumberFormatter.init()
        formatter.maximumFractionDigits = num
        formatter.minimumFractionDigits = num
        formatter.roundingMode = .down
//        formatter.numberStyle = .decimal
        let f = Float("\(self)") ?? 0
        let s = formatter.string(for: self) ?? "0"
        
        return s
//        let sizeStr = formatter.string(from: NSNumber.init(value: f)) ?? "0"
//        return sizeStr
    }
}

let f:CGFloat = 1695663.1448 / 10
print(f.digitalStr(num: 4))
