class Cat {
    var name: String?
}

struct Dog {
    var name: String?
}

let yellowCat = Cat()
yellowCat.name = "Hah"
print(yellowCat.name as Any)

var yellowDog = Dog()
yellowDog.name = "Brit"
print(yellowDog.name as Any)

let yellowLostCat = yellowCat
yellowLostCat.name = "Meow"
print(yellowCat.name as Any)
print(yellowLostCat.name as Any)

var yellowLostDog = yellowDog
yellowLostDog.name = "Raff"
print(yellowDog.name as Any)
print(yellowLostDog.name as Any)
