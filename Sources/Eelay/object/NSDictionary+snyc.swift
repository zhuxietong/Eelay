//
//  NSDictionary+snyc.swift
//
//  Created by 朱撷潼 on 15/3/12.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import Foundation

public typealias SnycBlock = (_:NSDictionaryChangeInfo) -> Void
 
public struct SyncScheme {
    public let keys:[String]
    public let primaryKey:String
    public let table:String
    public init(keys:[String],primaryKey:String,table:String){
        self.keys = keys
        self.primaryKey = primaryKey
        self.table = table
    }
}

public struct NSDictionaryChangeInfo {
    public let key:String
    public let value:Any
    public let dict:NSMutableDictionary
}

extension NSMutableDictionary{
    
    public var snycBlock:SnycBlock?{
        get{
            return syncOBJ.snycBlock
        }
        set{
            syncOBJ.snycBlock = newValue
        }
    }

    public func stopSync() {
        
    }
    
    public func startSync(scheme:SyncScheme){
        syncOBJ.syncScheme = scheme
    }
    
    public func syncUpdate(value:Any,for key:String) {
        self.setValue(value, forKey: key)

        guard let scheme = syncOBJ.syncScheme else {
            return
        }
        guard let primaryValue = self.value(forKey: scheme.primaryKey) else {
            return
        }
        
        let notice = "NSMutableDictionary.\(scheme.table).change.\(scheme.primaryKey)=\(primaryValue)"
        let change = NSDictionaryChangeInfo(key: key, value: value, dict: self)
        NotificationCenter.default.post(name: notice.__notice_name, object: change)
    }
    
    private struct ValueAssociatedKeys {
           static var valueObserver = "valueObserver"
    }
    var syncOBJ: ValueObserver {
           get {
            let v = objc_getAssociatedObject(self, &ValueAssociatedKeys.valueObserver) as? ValueObserver
            if let v_ = v{
               return v_
            }else{
                let obs = ValueObserver()
                obs.obj = self
                  objc_setAssociatedObject(self, &ValueAssociatedKeys.valueObserver, obs, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return obs
            }
           }
       }
    
}
class ValueObserver:NSObject{
    
    override init() {
        super.init()

    }
    
    @objc func changeValue(_ notify:Notification){
        guard let scheme = syncScheme,let dict = obj else {
            return
        }
        if let info = notify.object as? NSDictionaryChangeInfo{
            if scheme.keys.contains(info.key){
                dict[info.key] = info.value
                snycBlock?(info)
            }
        }
    }

   


    
    var syncScheme:SyncScheme? = nil{
        didSet{
            updateObserver()
        }
    }
    var snycBlock:SnycBlock? = nil
    
    var observerKey:String? = nil{
        didSet{
            if let oldV  = oldValue{
                NotificationCenter.default.removeObserver(self, name: oldV.__notice_name, object: nil)
            }
            if let newV = observerKey{
                NotificationCenter.default.addObserver(self, selector: #selector(changeValue(_:)), name: newV.__notice_name, object: nil)
            }
        }
    }
    
  
    weak var obj:NSMutableDictionary? = nil{
        didSet{
            updateObserver()
        }
    }
    
    func updateObserver() {
        guard let obj_ = obj, let scheme = syncScheme else {
            return
        }
        guard let primaryValue = obj_.value(forKey: scheme.primaryKey) else {
            return
        }
        let notice = "NSMutableDictionary.\(scheme.table).change.\(scheme.primaryKey)=\(primaryValue)"
        observerKey = notice

    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: observerKey?.__notice_name, object: nil)
        observerKey = nil
    }
  
    deinit {
        removeObserver()
    }
}
extension String{
    var __notice_name:NSNotification.Name{
        get{
            return NSNotification.Name(rawValue: self)
        }
    }
}
