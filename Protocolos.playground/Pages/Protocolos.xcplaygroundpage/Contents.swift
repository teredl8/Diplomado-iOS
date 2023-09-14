import Foundation

//Protocolos
//Permite definir la lista mínima de características que queremos
//Se modifica el código de la página "Introduccion" para usar protocolos 

struct Person {
    let name: String
    let age: Int
    let yearOfExperience: Int
}

struct Department: TabularDataSource, CustomStringConvertible {
    let name: String
    var people = [Person]()
    
    //Variable requerida para el uso del protocolo CustomStringConvertible
    var description: String {
        return "Department: \(name)"
    }

    init(name: String) {
        self.name = name
    }
    
    mutating func add(_ person: Person) {
        people.append(person)
    }
    
    var numberofRows: Int { people.count }
    var numberOfColumns: Int { 3 }
    
    func label(forColumn column: Int) -> String {
        switch column {
        case 0:
            return "Employee name"
        case 1:
            return "Age"
        case 2:
            return "Years of experience"
        default: fatalError("Invalid column header index!")
        }
    }
    
    func itemFor(row: Int, column: Int) -> String {
        let person = people[row]
        
        switch column {
        case 0: return person.name
        case 1: return String(person.age)
        case 2: return String(person.yearOfExperience)
        default: fatalError("Invalid column for person!")
        }
    }
}

protocol TabularDataSource {
    var numberofRows: Int { get }
    var numberOfColumns: Int { get }
    
    func label(forColumn column: Int) -> String
    func itemFor(row: Int, column: Int) -> String
}

//Solo podemos acceder a las propiedades que tiene el protocolo
func printTable(_ dataSource: TabularDataSource) {
    var headerRow = "|"
    var columnWitdths = [Int]()
    
    for index in 0..<dataSource.numberOfColumns {
        let columnLabel = dataSource.label(forColumn: index)
        let columnHeader = "\(columnLabel) |"
        headerRow += columnHeader
        columnWitdths.append(columnLabel.count)
    }
    
    
    print(headerRow)
    
    
    for index in 0..<dataSource.numberofRows {
        var output = "|"
        
        for columnIndex in 0..<dataSource.numberOfColumns {
            let item = dataSource.itemFor(row: index, column: columnIndex)
            let paddingNeeded = columnWitdths[columnIndex] - item.count
            let padding = repeatElement(" ", count: paddingNeeded).joined(separator: "")
            output += "\(padding)\(item) |"

        }
        
        print(output)
    }
}

var department = Department(name: "Engineering")
department.add(Person(name: "Eva", age: 30, yearOfExperience: 6))
department.add(Person(name: "Saleh", age: 40, yearOfExperience: 18))
department.add(Person(name: "Amit", age: 50, yearOfExperience: 20))

printTable(department)
print(department)

//let operationsDataSource: TabularDataSource = Department(name: "Other department")
//let engineeringDataSource = department as TabularDataSource
//
//let testPerson = Person(name: "Alejandro", age: 27, yearOfExperience: 5)
//department is TabularDataSource
