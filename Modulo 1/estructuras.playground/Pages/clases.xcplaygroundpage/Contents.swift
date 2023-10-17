//: [Previous](@previous)

import Foundation

class Vehicle {
    var brand: String
    let model: String
    var owner: String?
    let serialNumber: String
    let wheels: Int?
    var isMoving: Bool = false

    //Inicializador designado - Todas las propiedades que deben tener valor se inicializan
    init(brand: String, model: String, serialNumber: String, wheels: Int?) {
        self.brand = brand
        self.model = model
        self.serialNumber = serialNumber
        self.wheels = wheels
    }
    
    var type: String {
        return (wheels ?? 0) > 0 ? "Land" : "Other"
    }
    
    var registration: (name: String, serialNumber: String, type: String)? {
        //Con get se pueden obtener los valores
        get {
            if let owner = owner {
                return (owner, serialNumber, type)
            }
            return nil 
        }
        set(newRegistration) {
            if let newRegistration = newRegistration {
                //Solo afecta la propiedad "owner"
                owner = newRegistration.name
            }
        }
    }
    
    //Métodos de instancia
    func move() {
        isMoving = true
    }
    
    func stop() {
        isMoving = false
    }
    
    func makeNoise() -> String { "Noise" }
    
    //Métodos de clase
    static func describe() {
        print("A vehicle!")
    }
    
}

let myVehicle = Vehicle(brand: "Benetti", model: "Oasis 40M", serialNumber: "1234567890", wheels: nil)

//Sólo cambia el nombre del propietario, aunque se dan otros datos no se hacen los cambios porque
//registration solo afecta la propiedad "owner"
myVehicle.registration = (name: "Grecia", serialNumber: "0987654321", type: "Other")


myVehicle.move()
myVehicle.isMoving
Vehicle.describe()

//Clase Car que hereda de Vehicle
class Car: Vehicle {
    //Sobeescribo la variable type
    override var type: String {
        return "Car"
    }
    
    var isElectric: Bool
    
    init(electric: Bool) {
        //Paso 1: Primero debemos de ver que la subclase ya tiene todas sus propiedades
        self.isElectric = electric
        //Paso 2: Después ver que se tienen todas las propiedades de la superclase
        //Se llama el inicializador de la clase padre
        super.init(brand: "Toyota", model: "Some", serialNumber: "11111", wheels: 4)
    }
    
    override func makeNoise() -> String { "BRRRRM" }
    
    //Inicializador designado: asignamos todas las propiedades que tenemos
    override init(brand: String, model: String, serialNumber: String, wheels: Int?) {
        isElectric = brand == "Toyota"
        super.init(brand: brand, model: model, serialNumber: serialNumber, wheels: wheels)
    }
    
    init(brand: String, model: String, serialNumber: String, isElectric: Bool) {
        self.isElectric = isElectric
        super.init(brand: brand, model: model, serialNumber: serialNumber, wheels: 4)
    }
    
    //Convenience llama al designado de su misma clase
    convenience init(suzukiModel model: String, serialNumber: String, isElectric: Bool, boughtBy name: String) {
        //En los convenience, primero tenemos que inicializar todo lo del desginado de nuestra clase
        self.init(brand: "Suzuki", model: model, serialNumber: serialNumber, isElectric: isElectric)
        //Luego agregamos más cosas que nos interesen 
        owner = name
    }
    
    override var brand: String {
        willSet(newBrand) {
            print("Brand new: \(newBrand)")
        } didSet (oldBrand){
            print("Brand old: \(oldBrand)")
        }
    }
}

let myCar = Car(electric: true)
myCar.isElectric
myCar.brand
myCar.makeNoise()

let yourCar = Car(brand: "Suzuki", model: "Swift", serialNumber: "1234567889", isElectric: false)
yourCar.brand = "Ford"


