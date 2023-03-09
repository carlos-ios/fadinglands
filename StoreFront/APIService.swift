//
//  APIService.swift
//  StoreFront
//
//  Created by Carlos Henderson on 3/9/23.
//

import Foundation

class APIService {
    static let shared = APIService()

    func login(credentials: Credentials,
               completion: @escaping (Result<Bool,Authenticate.AuthenticationError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if (KeychainStorage.getCredentials() != nil) {
                completion(.success(true))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}

