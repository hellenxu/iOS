//
//  TipCalculator.swift
//  Playground
//
//  Created by Hellen on 2021-05-04.
//  Copyright © 2021 Six. All rights reserved.
//

import Foundation

struct TipCalculator{
    
    func calculateTip(total: Float, tip: Float, splitNum: Int) -> String {
        let eachAmt = total * (1 + tip)/Float(splitNum)
        return String(format: "%.2f", eachAmt)
    }
}
