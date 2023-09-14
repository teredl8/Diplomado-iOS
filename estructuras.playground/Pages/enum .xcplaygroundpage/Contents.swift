//: [Previous](@previous)

import Foundation

enum Pet: String {
    case dog = "🐶"
    case cat = "😺"
    
    var type: String {
        switch self {
        case .dog, .cat: return "Mamífero"
            
        }
    }
    
    init?(name: String) {
        switch name {
        case "dog": self.init(rawValue: "🐶")
        case "cat": self.init(rawValue: "😺")
        default: return nil
        }
    }
}

let myPet = Pet.dog.type

let myDog = Pet(name: "dog")

