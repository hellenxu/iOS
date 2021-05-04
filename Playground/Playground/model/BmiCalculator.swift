//
//  BmiCalculator.swift
//  Playground
//
//  Created by Hellen on 2021-05-03.
//  Copyright © 2021 Six. All rights reserved.
//

import UIKit

struct BmiCalculator {
    var bmi: BMI?
    
    func calculateBmi(weight: Float, height: Float) -> BMI {
        let bmiValue = weight / pow(height, 2)
        let bmiAdvice: String
        let bgColor: UIColor
        if bmiValue < 18.5 {
            bgColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            bmiAdvice = "Eat more meat"
        } else if bmiValue <= 24.9 {
            bgColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
            bmiAdvice = "Fit as model"
            print("normal")
        } else {
            bgColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            bmiAdvice = "Eat less meat"
        }
        
        return BMI(value: bmiValue, advice: bmiAdvice, backgroundColor: bgColor)
    }
}

struct BMI {
    let value: Float
    let advice: String
    let backgroundColor: UIColor
}
