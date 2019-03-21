//
//  ExploreDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class ExploreDataManager {
    fileprivate var items: [ExploreItem] = []
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func getItem(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
    func fetch() {
        for item in loadData() {
            items.append(ExploreItem(dict: item))
        }
    }
    
    fileprivate func loadData () ->[[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
            let items = NSArray(contentsOfFile: path) else {
                return [[:]]
        }
        
        return items as! [[String: AnyObject]]
    }
}
