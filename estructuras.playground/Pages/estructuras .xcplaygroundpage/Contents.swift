import Foundation

struct Dog {
    var name: String
    var isAdopted: Bool = true
    let color: String
    
    
    static func describeADog() -> String {
        return "a"
    }

//Podemos tener más de un inicializador de acuerdo a nuestras necesidades
    init(name: String, isAdopted: Bool, color: String) {
        self.name = name
        self.isAdopted = isAdopted
        self.color = color
    }
    
    init(adopted name: String, color: String) {
        self.name = name
        self.isAdopted = true
        self.color = color
    }
    
    init(bought name: String, color: String) {
        self.init(name: name, isAdopted: false, color: color)
    }
    
    init() {
        self.init(adopted: "Milaneso", color: "Brown")
    }
}

var myDog = Dog(name: "MIlaneso", isAdopted: true, color: "Brown")
myDog.isAdopted = false
myDog.name = "Dante"
//myDog.paws = 3
//myDog.specialNeeds

var anotherDOg = Dog()
