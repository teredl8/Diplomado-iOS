//: [Previous](@previous)

//Pruebas unitarias
import XCTest

class MyTest: XCTestCase {
    
    
    func getFullName(_ nameTuple: (String, String?, String, String?)) -> String {
        var fullName = ""
        
        fullName = fullName + nameTuple.0
        
        if nameTuple.1 == nil || nameTuple.1 == "" {
            fullName = fullName + " "
        } else {
            fullName = fullName + " " + nameTuple.1! + " "
        }
        
        fullName = fullName + nameTuple.2
        
        if nameTuple.3 == nil || nameTuple.3 == "" {
            fullName = fullName + ""
        } else {
            fullName = fullName + " " + nameTuple.3!
        }
        
        
        //return nameTuple.0 + " " + (nameTuple.1 ?? "") + " " + nameTuple.2 + " " + (nameTuple.3 ?? "")
        
        return fullName
    }
    
    
    
    //Sintaxis para función:
    //No recibe parámetros, no devuleve nada y el nombre debe iniciar con test seguido de _
    func test_GetFullName () {
        //Consta de tres partes
        
        //Given - ponemos qué es lo que tenemos
        let firstPerson: (String, String?, String, String?) = (first: "Grecia", second: "Itzel", firstLastName: "Escárcega", secondLastName: "Maldonado")
        let secondPerson: (String, String?, String, String?) = (first: "Manuel", second: nil, firstLastName: "Pérez", secondLastName: nil)
        let thirdPerson: (String, String?, String, String?) = (first: "Tere", second: "", firstLastName: "Durán", secondLastName: "López")
        
        //When - ¿Qué queremos que pase? - Es el proceso
        let firstFullName = getFullName(firstPerson)
        let secondFullName = getFullName(secondPerson)
        let thirdFullName = getFullName(thirdPerson)
        
        //Then
        //Esta prueba ve si lo que se tiene como resultado es igual a lo esperado
        
        
        XCTAssertEqual(firstFullName, "Grecia Itzel Escárcega Maldonado")
        XCTAssertEqual(secondFullName, "Manuel Pérez")
        XCTAssertEqual(thirdFullName, "Tere Durán López")
    }
    
    
}

MyTest.defaultTestSuite.run()

