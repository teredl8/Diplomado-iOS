//
//  KeychainServiceTest.swift
//  KeychainExampleTests
//
//  Created by Diplomado on 19/01/24.
//

import XCTest
@testable import KeychainExample //Se agrega para traer todo el proyecto

final class KeychainServiceTest: XCTestCase {
    let service = KeychainService()
    let testKey: String = "kcExample:\(UUID().uuidString)"

    override func tearDownWithError() throws {
        service.delete(key: testKey)
    }

    func testSaveKeyWithoutError() throws {
        try! service.save(key: testKey, value: "IAmVengance!🦇")
        XCTAssert(true)
    }
    
    func testSaveAndLoadKey() throws {
        try! service.save(key: testKey, value: "IAmVengance!🦇")
        let data = try! service.load(key: testKey)
        XCTAssertNotNil(data)
        XCTAssertEqual(data, "IAmVengance!🦇")
    }
    
    func testDeleteKey() throws {
        let key = "NaNaNABatman"
        try! service.save(key: key, value: "IAmVengance!🦇")
        service.delete(key: key)
        let result = try? service.load(key: key)
        XCTAssertNil(result)
    }
    
    func testAyncSaveWithoutError() throws {
        let expectation = XCTestExpectation(description: "Save in queue")
        service.save(key: testKey, value: "IAmVengance!🦇") { err in
            XCTAssertNil(err)
            expectation.fulfill()
        }
    }
}
