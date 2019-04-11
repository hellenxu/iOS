//
//  FilterManager.swift
//  EatEat
//
//  Created by Hellen on 2019-04-11.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    
    func fetch(completionHandler: (_ items: [FilterItem]) -> Swift.Void) {
        var items: [FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
