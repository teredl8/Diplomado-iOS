//
//  KeychainService.swift
//  KeychainExample
//
//  Created by Diplomado on 19/01/24.
//

import Foundation

struct KeychainService {
    let defaultService = "mx.unam.ioslab.keychainexample" //Debe ser única
    
    enum KeychainError: Error {
        case noPassword
        case unhandledError(status: OSStatus)
    }
    
    private let queue = DispatchQueue(label: "mx.unam.ioslab.keychainexample.keychainservice")
    
    func save(key: String, value: String, completion: @escaping(Error?) -> Void) {
        queue.async {
            do {
                try self.save(key: key, value: value)
                completion(nil)
            } catch let err {
                completion(err)
            }
        }
    }
    
    func save(key account: String, value: String) throws {
        guard let data = value.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: defaultService,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    func load(key account: String) throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: defaultService,
            kSecAttrAccount as String: account,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status != errSecItemNotFound else {
            throw KeychainError.noPassword
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unhandledError(status: status)
        }
        
        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }
    
    func delete(key account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: defaultService,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }
}
