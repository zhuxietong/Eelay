//
//  File.swift
//  
//
//  Created by zhuxietong on 2020/12/28.
//

import Foundation
import Eelay

print("SLLS")

class SObj:NSObject{
    
}
extension SObj{
    typealias object = NSMutableDictionary
    public static func secret(_ raw:String,format:String="3****4") -> String {
            do {
                
                let s = try Regex(string: "(\\d+)([^\\d]+)(\\d+)").allMatches(in:format)
                var strs:[String] = []
                if let c = s.first?.captures{
                    for one in c {
                        if  let str = one {
                            strs.append(str)
                        }
                    }
                }
                let leftLength = Int(strs.first ?? "0") ?? 0
                let rightLength = Int(strs.first ?? "0") ?? 0
                let center = strs[1]

                if (leftLength + rightLength + center.count) <= raw.count{
                    let startIndex = raw.index(raw.startIndex, offsetBy: leftLength)
                    
                    let endIndex = raw.index(raw.endIndex, offsetBy: -rightLength)

                    let left = String(raw[..<startIndex])
                    let rigth = String(raw[endIndex..<raw.endIndex])
                    
                    let result = "\(left)\(center)\(rigth)"
                    return result
                }else{
                    return raw
                }
               

                
              } catch {
                print("error building validation:\(error)")
                return raw
            }

    }
}
