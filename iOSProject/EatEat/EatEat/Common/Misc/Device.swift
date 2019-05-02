//
//  Device.swift
//  EatEat
//
//  Created by Hellen on 2019-05-01.
//  Copyright © 2019 Six. All rights reserved.
//

import UIKit

struct Device {
    static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
