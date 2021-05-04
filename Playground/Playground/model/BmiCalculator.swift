//
//  BmiCalculator.swift
//  Playground
//
//  Created by Hellen on 2021-05-03.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct BmiCalculator {
    
    func calculateBmi(weight: Float, height: Float) -> Float {
        return weight / pow(height, 2)
    }
}
