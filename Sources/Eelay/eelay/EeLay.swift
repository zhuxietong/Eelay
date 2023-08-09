//
//  EeLay.swift
//  EeLay
//
//  Created by zhuxietong on 2016/12/16.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit


fileprivate struct SoNode<DataType>{
    static func count(list:[Any]) -> Int
    {
        var count = 0
        for one in list
        {
            if let _ = one as? DataType
            {
                count += 1
            }
        }
        return count
    }
}


fileprivate class SoPaw {
    public static func strings<T:Sequence>(list:T) ->[String]
    {
        var str_values = [String]()
        for t in list
        {
            str_values.append("\(t)")
        }
        return str_values
    }
}


prefix operator .>
prefix operator .<


public prefix func .><T>(value:T) -> [String:T]  {
    
    return [">":value]
}


public prefix func .<<T>(value:T) -> [String:T]  {
    return ["<":value]
}



infix operator .+

public func .+<T>(value:T,p:Double) -> Any  {
    if var one = value as? [String:NumberValue]
    {
        one["p"] = p.doubleValue
        return one
    }
    if var one = value as? [String:String]{
        one["p"] = "\(p)"
        return one
    }
    
    if let num = value as? NumberValue
    {
        return ["=":num.doubleValue,"p":p]
    }
    
    if value is String
    {
        return ["=":value,"p":"\(p)"] as [String : Any]
    }
    return value
    
}




public typealias ee = easy

enum EasyTarget{
    case view
    case safeArea
    case none
}

open class easy {
    
    static var priority:Float = 800
    
    public class lay{
        var value:NSLayoutConstraint.Attribute
        var target:EasyTarget = .view
        
        public func constrainTarget(view:UIView?) -> Any? {
            switch self.target {
            case .safeArea:
                if #available(iOS 11.0, *) {
                    return view?.safeAreaLayoutGuide
                } else {
                    return view
                    // Fallback on earlier versions
                }
            case .none:
                return nil
            default:
                return view
            }
        }
        
        init(v:NSLayoutConstraint.Attribute){
            self.value = v
        }
    }
    
    public class map{
        var values:[lay] = [lay]()
        
        init(v:NSLayoutConstraint.Attribute,p:Float=easy.priority){
            self.values.append(lay(v: v))
        }
        
        
        
        public var T:easy.map{
            self.values.append(lay(v: .top))
            return self
        }
        public var B:easy.map{
            self.values.append(lay(v: .bottom))
            return self
        }
        public var L:easy.map{
            self.values.append(lay(v: .left))
            return self
        }
        public var R:easy.map{
            self.values.append(lay(v: .right))
            return self
        }
        public var X:easy.map{
            self.values.append(lay(v: .centerX))
            return self
        }
        public var Y:easy.map{
            self.values.append(lay(v: .centerY))
            return self
        }
        public var safe:easy.map{
            for one in values {
                one.target = .safeArea
            }
            return self
        }
        public var view:easy.map{
            for one in values {
                one.target = .view
            }
            return self
        }
        public var none:easy.map{
            for one in values {
                one.target = .none
            }
            return self
        }
        
        public var width:easy.map{
            self.values.append(lay(v: .width))
            return self
        }
        
        public var height:easy.map{
            self.values.append(lay(v: .height))
            return self
        }
        
    }
    
    
    public static var T:easy.map{
        return map(v: NSLayoutConstraint.Attribute.top)
    }
    public static var B:easy.map{
        return map(v: NSLayoutConstraint.Attribute.bottom)
    }
    public static var L:easy.map{
        return map(v: NSLayoutConstraint.Attribute.left)
    }
    public static var R:easy.map{
        return map(v: NSLayoutConstraint.Attribute.right)
    }
    public static var X:easy.map{
        return map(v: NSLayoutConstraint.Attribute.centerX)
    }
    public static var Y:easy.map{
        return map(v: NSLayoutConstraint.Attribute.centerY)
    }
    
    
    public static var width:easy.map{
        return map(v: NSLayoutConstraint.Attribute.width)
    }
    
    public static var height:easy.map{
        return map(v: NSLayoutConstraint.Attribute.height)
    }
    
    public static var none:easy.map{
        return map(v: NSLayoutConstraint.Attribute.notAnAttribute)
    }

}




//
//
//public struct TP {
//
//}
//
//public extension TP
//{
//    typealias lays = [[Any]]
//}
//
//
//
//
//extension String
//{
//    var cg_float:CGFloat{
//        get{
//            let str = NSString(string: self)
//            return CGFloat(str.floatValue)
//        }
//    }
//}
//

public extension TP
{
    typealias lays = [[Any]]
}




extension String
{
    var cg_float:CGFloat{
        get{
            let str = NSString(string: self)
            return CGFloat(str.floatValue)
        }
    }
}




public extension UIView{
    
    var eelay:TP.lays {
        set(newValue){
            let format = UIView.eeformat(lays: newValue)
            _ = UIView.eelay(lays: format, at: self)
        }
        get{
            return TP.lays()
        }
    }
    
    @discardableResult
    func setEeLays(lays:TP.lays) ->([[NSLayoutConstraint]],[NSLayoutConstraint]) {
        let format = UIView.eeformat(lays: lays)
        //            print(format)
        return UIView.eelay(lays: format, at: self)
    }
    
    
    @discardableResult
    func append(_ rules:Any...)->[NSLayoutConstraint] {
        if let superV = self.superview
        {
            let new_rules = [self] + rules
            let lays = [
                new_rules
            ]
            let format = UIView.eeformat(lays: lays)
            
            //            print(format)
            return UIView.eelay(lays: format, at: superV).1
        }
        
        return [NSLayoutConstraint]()
    }
    
    
    static func eeformat(lays:TP.lays) -> TP.lays {
        var new_lays = [[Any]]()
        
        for one_lay in lays
        {
            var new_one = [Any]()
            for lay in one_lay
            {
                //视图-------------------------------------------
                if let view = lay as? UIView //first view
                {
                    new_one.append(view)
                }
                
                //宽度-------------------------------------------
                if let width = lay as? NumberValue
                {
                    new_one.append(width.doubleValue.+Double(easy.priority))
                }
                
                //高度-------------------------------------------
                if let height = lay as? String //height
                {
                    let ps = height.+Double(easy.priority)
                    new_one.append(ps)
                }
                
                
                //宽度或高度-------------------------------------------
                if let dict = lay as? [String:Any] //height
                {
                    new_one.append(dict)
                }
                
                //约束-------------------------------------------
                if let list = lay as? [Any] //height
                {
                    var new_list = [Any]()
                    for constain in list
                    {
                        if let values = constain as? [Any]
                        {
                            var new_values = [Any]()
                            for one_value in values
                            {
                                if let value = one_value as? [String:Any]
                                {
                                    new_values.append(value)
                                }
                                else{
                                    new_values.append(one_value.+Double(easy.priority))
                                }
                            }
                            new_list.append(new_values)
                        }
                        else if constain is UIView{
                            new_list.append(constain)
                        }
                        else if constain is easy.map{
                            new_list.append(constain)
                        }
                        else if constain is [String:Any]{
                            let list = [constain]
                            new_list.append(list)
                        }
                        else
                        {
                            new_list.append([constain.+Double(easy.priority)])
                        }
                    }
                    new_one.append(new_list)
                }
            }
            
            new_lays.append(new_one)
        }
        
        return new_lays
    }
    
    
    @discardableResult
    class func eelay<T:UIView>(lays:TP.lays,at:T)->([[NSLayoutConstraint]],[NSLayoutConstraint]) {
        
        var constrains = [[NSLayoutConstraint]]()
        if lays.count > 0
        {
            for oneLays in lays{
                if let one_view = oneLays[0] as? UIView
                {
                    one_view.translatesAutoresizingMaskIntoConstraints = false
                    
                    if one_view !== at
                    {
                        if let o = one_view.superview
                        {
                            if o !== at
                            {
                                at.addSubview(one_view)
                            }
                        }
                        else
                        {
                            at.addSubview(one_view)
                        }
                    }
                }
            }
            
            
            for oneLays in lays{
                var one_constains = [NSLayoutConstraint]()
                
                var t_view:UIView = at
                
                var item_lays = oneLays
                if let t_view_1 = item_lays[0] as? UIView
                {
                    t_view = t_view_1
                    item_lays.remove(at: 0)
                    //                    at.addSubview(t_view)
                    
                }
                
                for one in item_lays
                {
                    //宽度或高度-----------------------------------
                    if let dict = one as? [String:Any]
                    {
                        //----------------------------高度
                        if let height = dict as? [String:String]
                        {
                            var relatedBy:NSLayoutConstraint.Relation = .equal
                            var value = "0"
                            
                            if height.keys.contains(">")
                            {
                                relatedBy = .greaterThanOrEqual
                                value = height[">"]!
                            }
                            if height.keys.contains("<")
                            {
                                relatedBy = .lessThanOrEqual
                                value = height["<"]!
                            }
                            if height.keys.contains("=")
                            {
                                relatedBy = .equal
                                value = height["="]!
                            }
                            
                            var priority = easy.priority
                            if height.keys.contains("p")
                            {
                                priority = Float(height["p"]!)!
                            }
                            
                            let c =  NSLayoutConstraint(item: t_view, attribute: .height, relatedBy: relatedBy, toItem: nil, attribute: .height, multiplier: 1, constant: value.cg_float)
                            
                            c.priority =  UILayoutPriority(rawValue: priority)
                            one_constains.append(c)
                            t_view.superview?.addConstraint(c)
                            
                            continue
                        }
                        else{
                            //----------------------------宽度
                            let width = dict
                            
                            var relatedBy:NSLayoutConstraint.Relation = .equal
                            var value = "0"
                            
                            if width.keys.contains(">")
                            {
                                relatedBy = .greaterThanOrEqual
                                let _value = width[">"]!
                                value = "\(_value)"
                            }
                            if width.keys.contains("<")
                            {
                                relatedBy = .lessThanOrEqual
                                let _value = width["<"]!
                                value = "\(_value)"
                            }
                            if width.keys.contains("=")
                            {
                                relatedBy = .equal
                                let _value = width["="]!
                                value = "\(_value)"
                            }
                            
                            var priority = easy.priority
                            if width.keys.contains("p")
                            {
                                let _priority = width["p"]!
                                priority = Float("\(_priority)")!
                            }
                            
                            
                            let c =  NSLayoutConstraint(item: t_view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: relatedBy, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: value.cg_float)
                            c.priority = UILayoutPriority(rawValue:priority)
                            
                            one_constains.append(c)
                            t_view.superview?.addConstraint(c)
                            
                            continue
                        }
                    }
                    
                    if let alay = one as? [Any]
                    {
                        var relate_v = t_view.superview
                        var one_lay:[Any] = Array<Any>(alay)
                        if  let v = alay[0] as? UIView
                        {
                            relate_v = v
                            one_lay.remove(at: 0)
                        }
                        
                        let co_count = SoNode<easy.map>.count(list: one_lay)
                        var to_atr = easy.none
                        var this_atr = easy.none
                        
                        
                        if co_count == 1
                        {
                            to_atr = one_lay[0] as! easy.map
                            this_atr = one_lay[0] as! easy.map
                        }
                        if co_count == 2
                        {
                            to_atr = one_lay[0] as! easy.map
                            this_atr = one_lay[1] as! easy.map
                        }
                        
                        //取值
                        var _values = [[String:Any]]()
                        if let v = one_lay.last as? [[String:Any]]
                        {
                            for one_v in v{
                                _values.append(one_v)
                            }
                        }
                        
                        if to_atr.values.count >= this_atr.values.count
                        {
                            for (i,lay0) in this_atr.values.enumerated()
                            {
                                
                                if lay0.value != NSLayoutConstraint.Attribute.notAnAttribute
                                {
                                    let lay1 = to_atr.values[i]
                                    
                                    var _v = ["p":easy.priority,"=":"0"] as [String : Any]
                                    if _values.count > i{
                                        _v = _values[i]
                                    }
                                    else if _values.count > 0
                                    {
                                        _v = _values[0]
                                    }
                                    else{}
                                    
                                    
                                    var relatedBy:NSLayoutConstraint.Relation = .equal
                                    var value = "0"
                                    if _v.keys.contains(">")
                                    {
                                        relatedBy = .greaterThanOrEqual
                                        let _value = _v[">"]!
                                        value = "\(_value)"
                                    }
                                    
                                    
                                    if _v.keys.contains("<")
                                    {
                                        relatedBy = .lessThanOrEqual
                                        let _value = _v["<"]!
                                        value = "\(_value)"
                                    }
                                    
                                    
                                    if _v.keys.contains("=")
                                    {
                                        relatedBy = .equal
                                        let _value = _v["="]!
                                        value = "\(_value)"
                                    }
                                    
                                    var priority = easy.priority
                                    if _v.keys.contains("p")
                                    {
                                        let _priority = _v["p"]!
                                        priority = Float("\(_priority)")!
                                    }
                                    
                                    let item = lay0.constrainTarget(view: t_view)
                                    let toItem = lay1.constrainTarget(view: relate_v)

                                    
                                    switch lay0.value {
                                    case .width,.height:
                                        var multiplier = value.cg_float
                                        if multiplier == 0{
                                            multiplier = 1
                                        }
                                        let x =  NSLayoutConstraint(item: item!, attribute: lay0.value, relatedBy: relatedBy, toItem: toItem, attribute: lay1.value, multiplier: multiplier, constant: 0)
                                            x.priority = UILayoutPriority(rawValue:priority)
                                            one_constains.append(x)
                                            t_view.superview!.addConstraint(x)
                                    default:
                                        let x =  NSLayoutConstraint(item: item!, attribute: lay0.value, relatedBy: relatedBy, toItem: toItem, attribute: lay1.value, multiplier: 1, constant: value.cg_float)
                                        
                                        x.priority = UILayoutPriority(rawValue:priority)
                                        one_constains.append(x)
                                        t_view.superview!.addConstraint(x)
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
                constrains.append(one_constains)
            }
        }
        
        var cons = [NSLayoutConstraint]()
        
        for cs in constrains
        {
            for one_c in cs
            {
                cons.append(one_c)
            }
        }
        
        return (constrains,cons)
    }
}











#endif
