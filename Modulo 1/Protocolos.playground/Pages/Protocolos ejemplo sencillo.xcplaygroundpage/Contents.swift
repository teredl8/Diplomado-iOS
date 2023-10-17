//: [Previous](@previous)

import Foundation

protocol Student: CustomStringConvertible {
    var accountNumber: Int { get }
    var nombre: String { get }
}

struct EngineeringStudent: Student {
    var accountNumber: Int
    var nombre: String
    
    let hasCalculator: Bool
    
    var description: String {
        "Engineering Student - \(nombre)"
    }
}

struct MedicineStudent: Student {
    var accountNumber: Int
    var nombre: String
    
    let hasLabCoat: Bool
    
    var description: String {
        "Medicine Student - \(nombre)"
    }
}

let engineeringStudent = EngineeringStudent(accountNumber: 123456789, nombre: "Alejandro", hasCalculator: false)
let medicineStudent = MedicineStudent(accountNumber: 987654321, nombre: "Mariana", hasLabCoat: true)

func printStudentsInformation(_ student: Student) {
    print("\(student.nombre) - \(student.accountNumber)")
    
    if let medicineStudent = student as? MedicineStudent {
        print(medicineStudent.hasLabCoat)
    }
}

printStudentsInformation(engineeringStudent)
printStudentsInformation(medicineStudent)

print(engineeringStudent)
print(medicineStudent)
