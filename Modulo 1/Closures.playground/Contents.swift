import Foundation

//Closures
let volunteerCounts = [1, 3, 40, 32, 2, 53, 77, 13]

/*func isAscending(_ i: Int, _ j: Int) -> Bool {
    return i < j
}

let volunteerSorted = volunteerCounts.sorted(by: isAscending)
*/

/*let volunteerSorted = volunteerCounts.sorted(by: {(i: Int, j: Int) -> Bool in
    i < j
})*/

//Simplificada
//let volunteerSorted = volunteerCounts.sorted(by: {i,j in i < j })

//Simplificada con elementos posicionales
//let volunteerSorted = volunteerCounts.sorted(by: { $0 < $1 })

//Más resumido
let volunteerSorted = volunteerCounts.sorted { $0 < $1 }

print(volunteerSorted)

//Ejemplo 2
func doAwsomeWork( on input: String,
                    using transformer: () -> Void,
                    then completion: () -> Void) {
    //Here would go the logic to do the awesome work
}

doAwsomeWork(on: "Diplomado") {
    //Here goes the transformer
} then: {
    //Here goes the completion
}

doAwsomeWork(on: "Diplomado", using: {}, then: {})

//Ejemplo 3
let volunteerAverages = [10.75, 4.2, 1.5, 12.12, 16.815]

func format(numbers: [Double],
    using formatter: (Double) -> String = {"\($0)"}) -> [String] {
    var result = [String]()
    
    for number in numbers {
        let transformedNumber = formatter(number)
        result.append(transformedNumber)
    }
    
    return result
}

func rounder(_ number: Double) -> String {
    let roundedNumber: Int = Int(number)
    return "\(roundedNumber)"
}

func addDescription(_ number: Double) -> String {
    return "Volunteer average: \(number)"
}

let formatterAverageVolunteers = format(numbers: volunteerAverages,
                                        using: rounder)

print(volunteerAverages)
print(formatterAverageVolunteers)

let averageVolunteerDescription = format(numbers: volunteerAverages, using: addDescription)

print(averageVolunteerDescription)

let defaultVolunteerFormat = format(numbers: volunteerAverages)
print(defaultVolunteerFormat)


//Programación funcional
//Ninguno de los siguientes métodos modifica la colección original que se les pasó 
//map
//Itera por cada uno de los elememntos de una secuencia y devuelve una secuencia de elementos modificados de acuerdo a una función, no modifica la secuencia original
//Regresa colección del mismo tamaño
let roundedVolunteers = volunteerAverages.map { number in
    return Int(number)
}
print(roundedVolunteers)

//filter
//Devuelve una secuencia del mismo tamaño o más pequeña
//No midifica la secuencia que se pasa, sino que da una copia transaformada
let passingVolunteers = roundedVolunteers.filter { number in
    return number >= 10
}
print(passingVolunteers)

//reduce
//Regresa un único valor
//Recibe una colección de datos, itera sobre ellos y devuelve un único valor
let totalVolunteers = passingVolunteers.reduce(0) {
    partialResult, number in
    return partialResult + number
}
print(totalVolunteers)

let finalVolunteerDescription = passingVolunteers.reduce("The volunteers were ") {
    partialResult, number in
    return partialResult + "\(number) "
}

print(finalVolunteerDescription)
