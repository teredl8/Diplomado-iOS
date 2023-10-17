import Foundation

func myAwsomePrintingFunction(name: String) {
    print("Hello \(name)! Welcome to the class")
}

myAwsomePrintingFunction(name: "Tere")

//Nombre debe ser descriptivo
func add(lhs: Int, rhs: Int) {
    print("\(lhs) + \(rhs) = \(lhs + rhs)")
}

add(lhs: 2, rhs: 2)

//Para este caso en los atributos se dan dos nombres para la variable
//El primer nombre "to" es el que se ve desde donde se hace la llamada de la función
//El segundo nombfre es el que se usa dentro de la función para hacerlo más claro dentro del contexto de la función
//En el segundo parámetro se asigna un valor por defecto, si no se manda nada se agregará ese valor
func printWelcomeMessage(to name: String, course: String = "Diplomado iOS") {
    print("Hello \(name), welcome to \(course)")
}

printWelcomeMessage(to: "Alejandro", course: "Diplomado Android")
//Se imprime con el valor por defecto
printWelcomeMessage(to: "Alejandro")

var error = "The process failed: "

func appendErrorCode(code: Int, toErrorString errorString: inout String) {
    if code == 400 {
        errorString += "bad request."
    }
}

print(error)
appendErrorCode(code: 400, toErrorString: &error)
print(error)


//Devolver datos
func welcomeMessage(to name: String) -> String {
    //Cuando nuestra función solo tiene una línea no es necesario usar el return
    return "Welcome \(name)"
}

let message = welcomeMessage(to: "Alejandro")
print(message)

//Return puede funcionar como break dentro de las funciones

//Scope de una función
//Función tiene acceso a lo que tiene dentro de las llaves
func areaOfTriangleWith(base: Double, height: Double) -> Double {
    let rectangle = base * height
    
    //Esta función puede ver lo que está afuera de ella
    //Pero la función de afuera no puede ver lo que está dentro de la función interna
    func divide() -> Double {
        return rectangle/2
    }
    
    return divide()
}

//Para regresar varios datos se pueden usar tuplas
func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {
    var evens = [Int]()
    var odds = [Int]()
    
    for number in numbers {
        if number % 2 == 0 {
            evens.append(number)
        } else {
            odds.append(number)
        }
    }
    
    return (evens: evens, odds: odds)
}

let aBunchOfNumbers = [10, 1, 4, 3, 57, 43, 27, 84]
let sortedEvenAndOddNumbers = sortedEvenOddNumbers(aBunchOfNumbers)
print("The even numbers are: \(sortedEvenAndOddNumbers.evens)")
print("The odd numbers are: \(sortedEvenAndOddNumbers.odds)")

//Optionals como parámetros
func grabMiddleName(fullName name: (first: String, middle: String?, last: String)) -> String? {
    return name.middle
}

let middleName = grabMiddleName(fullName: (first: "Alejsndro", middle: nil, last: "Mendoza"))

if let middleName = middleName {
    print(middleName)
}

func greetByMiddleName(fromFullName name: (first: String, middle: String?, last: String), age: Int) {
    //Cuando en las condiciones ponemos "," se deben cumplir todas las condiciones
    
    //Si no cumple con las condiciones hace lo de dentro de las llaves de guard
    guard let middleName = name.middle, age > 18 else {
        print("Hey there!")
        return
    }
    
    //Si sí lo cumple hace lo que sigue después del guard
    print("Hey, \(middleName)")
}

greetByMiddleName(fromFullName: (first: "Alejandro", middle: "Oscar", last: "Mendoza"), age: 19)

//TIpos de datos de funciones

//func sortedEvenOddNumbers(_ numbers: [Int]) -> (evens: [Int], odds: [Int]) {}
//El tipo de dato de esta función es el siguiente
//func myFunction([]) ->([Int], [Int]) {}

//myFunction = sortedEvenAndOddNumbers
