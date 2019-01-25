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

