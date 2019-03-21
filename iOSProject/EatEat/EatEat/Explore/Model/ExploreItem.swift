//
//  ExploreItem.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

struct ExploreItem{
    var name: String
    var image: String
}

extension ExploreItem {
    init(dict: [String: AnyObject]) {
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
