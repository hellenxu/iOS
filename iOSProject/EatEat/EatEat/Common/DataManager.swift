//
//  DataManager.swift
//  EatEat
//
//  Created by Hellen on 2019-03-22.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

protocol DataManager{
    func load(file name: String) -> [[String:AnyObject]]
}

extension DataManager {
    func load(file name: String) -> [[String:AnyObject]] {
        guard let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let items = NSArray(contentsOfFile: path) else { return [[:]] }
        return items as! [[String:AnyObject]]
    }
}
