//: [Previous](@previous)

import Foundation

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
    
    mutating func pushAll<S: Sequence>(_ sequence: S) where S.Element == Element {
        for item in sequence {
            self.push(item)
        }
    }
}

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

let mySet: Set<Int> = [1,2,3,4]
myStack.pushAll(mySet)


