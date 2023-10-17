import Foundation

//MAP
//Esta es la firma de la función func myMap<T, U>(_ items: [T], _ transformer: (T) -> (U)) -> [U]
func myMap<T, U>(_ items: [T], _ transformer: (T) -> (U)) -> [U] {
    var result = [U]()
    for item in items {
        let transformedItem = transformer(item)
        result.append(transformedItem)
    }
    return result
}

//De acuerdo a la aplicación que le de a la función genérica, los tipos genéricos de los parámetros
//toman un tipo de dato específico
//En este caso T se vuelve String y U se toma como Int
let myStrings = ["one", "two", "three"]
let stringsLengths = myMap(myStrings) { $0.count }
print(stringsLengths)

///Maping a Stack
///

//Definiendo un Stack de cualquier tipo de datos
struct Stack<Element>: Sequence {
    typealias Iterator = StackIterator
    
    typealias Element = StackIterator<Element>.Element
    
    var items = [Element]()
    
    mutating func push(_ newItem: Element) {
        items.append(newItem)
    }
    
    mutating func pop() -> Element? {
        guard !items.isEmpty else { return nil }
        
        return items.removeLast()
    }
    
    func myMap<U>(_ transformer: (Element) -> (U)) -> Stack<U> {
        var result = [U]()
        for item in items {
            let transformedItem = transformer(item)
            result.append(transformedItem)
        }
        return Stack<U>(items: result)
    }
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
}

var intStack = Stack<Int>()
intStack.push(1)
intStack.push(2)

var doubleSTack = intStack.myMap { $0 * 2 }
/*
print(intStack.pop())
print(intStack.pop())

print(doubleSTack.pop())
print(doubleSTack.pop())
*/
//Protocolo Equatable permite comparar dos objetos del mismo tipo como ==
func checkIfEqual<T: Equatable>(_ first: T, _ second: T) -> Bool {
    return first == second
}

print(checkIfEqual("one", "two"))


func checkIfDescriptionsMatch<T: CustomStringConvertible,
    U: CustomStringConvertible>(first: T, _ second: U) -> Bool {
    return first.description == second.description
}

//Checha si el método description de los elementos son iguales
print(checkIfDescriptionsMatch(first: Int(1), UInt(1)))
print(Int(1))
print(UInt(1))

print(checkIfDescriptionsMatch(first: Float(1), Double(1)))

/*
//No se puede definir un protocolo genérico
//Si se puede que un protocolo tenga un tipo de dato genérico
protocol IteratorProtocol {
    associatedtype Element
        mutating func next() -> Element?
}

//Tiene dos tipos asociados
protocol Sequence {
    associatedtype Iterator: IteratorProtocol
    associatedtype Element where Element == Iterator.Element
    
    func makeIterator()-> Iterator
}
*/

struct StackIterator<T>: IteratorProtocol {
    typealias Element = T
    
    var stack: Stack<T>
    
    mutating func next() -> T? {
        return stack.pop()
    }
}

var myStack = Stack<Int>()
myStack.push(10)
myStack.push(20)
myStack.push(30)
myStack.push(40)

for value in myStack {
    print("For in loop: got \(value)")
}

var myStackIterator = StackIterator(stack: myStack)
while  let value = myStackIterator.next() {
    print(value)
}

