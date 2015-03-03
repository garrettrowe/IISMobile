//
//  IBM_Item.swift
//  Bluemix Viewer
//
//  Created by Garrett Rowe on 2/25/15.
//  Copyright (c) 2015 Garrett Rowe. All rights reserved.
//

import UIKit

class IBM_Item: IBMDataObject,IBMDataObjectSpecialization {
    
    let nameKey = "name"
    let priorityKey = "priority"
    
    var name: String {
        get {
            if let nameStr = super.objectForKey(nameKey) as? String {
                return nameStr
            } else {
                return ""
            }
        }
        set {
            super.setObject(newValue, forKey: nameKey)
        }
        
    }
    
    //Priority value with a range from 0 to 2 [0,2] used to sort the IBM_Item list
    var priority: Int {
        
        get {
            if let priorityInt = super.objectForKey(priorityKey) as? Int {
                return priorityInt
            } else {
                return 0
            }
        }
        set {
            super.setObject(newValue, forKey: priorityKey)
        }
    }
    
    required override init() {
        super.init()
    }
    
    override init(`class` classname: String!) {
        super.init(`class`:classname)
    }
    
    class func dataClassName() -> String! {
        return "Item"
    }
}
