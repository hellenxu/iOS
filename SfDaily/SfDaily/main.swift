//
//  main.swift
//  SfDaily
//
//  Created by Hellen on 2019-01-24.
//  Copyright © 2019 Six. All rights reserved.
//

import Foundation

print("Hello, World!")

// equation
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if(quotation == sameQuotation) {
    print("These two strings are considered equal.")
}

//hasPrefix
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall i Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard"]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if(scene.hasPrefix("Act 1")){
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1.")

//unicode
let dogString = "Dog!"
for codeUnit in dogString.utf8 {
    print("\(codeUnit)")
}
print("\n")


//control flow - for-in loop
let individualScores = [74, 56, 90, 100, 400]
var bonusScore = 0
for score in individualScores {
    if(score > 90) {
        bonusScore += 10
    } else {
        bonusScore -= 5
    }
}
print("Your bonus score is \(bonusScore)")

//control flow - iteration of dictionary
let interestingNumbers = [
    "Prime": [1, 2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8, 13, 21],
    "Square": [1, 4, 9, 16, 25, 36, 49]
]
var max = 0
for(_, numbers) in interestingNumbers {
    for num in numbers {
        if(num > max) {
            max = num
        }
    }
}
print("max is \(max)")

//control flow - switch
let someCharacter = "z"
switch someCharacter {
case "a":
    print("The first letter of the alphabet.")
case "z":
    print("The last letter of the alphabet.")
default:
    print("Some other character")
}

//Functions with Multiple Return Values
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if(value < currentMin) {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

print("min and max of array is \(minMax(array: [10, 3, 9, 100, 2, -10, 100]))")


func rangeSample() {
    let closedRange = 10 ... 20
    let halfClosedRange = 10 ..< 20
    
    for value in closedRange {
        print("closed range value: \(value)")
    }
    
    for value in halfClosedRange {
        print("half-closed range value: \(value)")
    }
    
    for value in closedRange.reversed() {
        print("reversed closed range value: \(value)")
    }
    
    for value in halfClosedRange[3...] {
        print("one-sided range value: \(value)")
    }
}

rangeSample()

func collectionSamples() {
    var states:[String] = []
    states.append("ON")
    states.append(contentsOf: ["Albert", "British Clumbia"])
    states.insert("Manitoba", at: 0)
    states.insert(contentsOf: ["Saskatchewan", "Quebec", "New Brunswick"], at: 2)
    
    for state in states {
        print("Selected State: \(state)")
    }
}

collectionSamples()

func dictionarySamples () {
    var dictPizzas = ["veggie": 14.99]
    dictPizzas["meat"] = 17.99
    if let oldValue = dictPizzas.updateValue(15.99, forKey: "meat") {
        print("old value: \(oldValue)")
    }
    
    dictPizzas["specialty"] = 18.99
    dictPizzas["chicken"] = 16.99
    if let chickenPizzaPrice = dictPizzas["chicken"] {
        print("chicken pizza: \(chickenPizzaPrice)")
    }
    
    for pizzaName in dictPizzas.keys {
        print("pizzaName: \(pizzaName)")
    }
    
    for (key, value) in dictPizzas {
        print("pizza: \(key); price: \(value)")
    }
}

dictionarySamples()
