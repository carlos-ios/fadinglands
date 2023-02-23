//
//  KeychainStorage.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/22/23.
//

import Foundation
import SwiftKeychainWrapper

enum KeychainStorage {
    static let key = "credentials"
    
    static func getCredentials() -> Credentials? {
        if let myCredentialsString = KeychainWrapper.standard.string(forKey: Self.key) {
            return Credentials.decode(myCredentialsString)
        } else {
            return nil
        }
    }
    
    static func saveCredentials(_ credentials: Credentials) -> Bool {
        if KeychainWrapper.standard.set(credentials.encoded(), forKey: Self.key) {
            print("saved")
            return true
        } else {
            print("not saved")
            return false
        }
    }
}
