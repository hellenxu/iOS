//
//  ExploreDataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-20.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

class ExploreDataManager: DataManager {
    fileprivate var items: [ExploreItem] = []
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func getItem(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
    func fetch() {
        for item in load(file: "ExploreData") {
            items.append(ExploreItem(dict: item))
        }
    }
    
}
