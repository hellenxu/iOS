//
//  FilterItem.swift
//  EatEat
//
//  Created by Hellen on 2019-04-11.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    let filter: String
    let name: String
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
