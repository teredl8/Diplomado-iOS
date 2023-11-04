import UIKit

// Los valores se quedan en el teléfono hasta que el usuario borre la aplicación
// Recomendación: los valores de las llaves trabajarlas en enum 
let defaults = UserDefaults.standard

// Guardar dato
defaults.set(5, forKey: "Entero")
defaults.setValue("5", forKey: "String")
defaults.setValue(["Uno", "Dos"], forKey: "Array")

// Recuperar un valor
let numero = defaults.object(forKey: "Entero")
let numeroDos = defaults.integer(forKey: "Entero")
defaults.integer(forKey: "String")
numeroDos + 3
defaults.array(forKey: "Array")

struct myStruct: Codable {
    var variableUno: String
    var variableDos: Int
}

let myArray = [myStruct(variableUno: "Uno", variableDos: 1), myStruct(variableUno: "Dos", variableDos: 2)]

// Guardar dato
if let encodedData = try? JSONEncoder().encode(myArray) {
    // Guardar el JSON codificado en UserDefaults con una clave específica
    defaults.set(encodedData, forKey: "myArrayKey")
}

if let savedData = defaults.data(forKey: "myArrayKey"), let decodedArray = try? JSONDecoder().decode([myStruct].self, from: savedData) {
    // 'decodedArray' ahora contiene los datos guardados
    print(decodedArray[0])
} else {
    // No se encontraron datos guardados o hubo un error al decodificar
}
