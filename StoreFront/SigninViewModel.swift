//
//  SigninViewModel.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/22/23.
//

import Foundation

class SigninViewModel : ObservableObject {
    @Published var credentials = Credentials()
        @Published var showProgressView = false
        @Published var error: Authenticate.AuthenticationError?
        @Published var storeCredentialsNext = false
        
        var loginDisabled: Bool {
            credentials.email.isEmpty || credentials.password.isEmpty
        }
        
        func login(completion: @escaping (Bool) -> Void) {
            showProgressView = true
            APIService.shared.login(credentials: credentials) { [unowned self](result:Result<Bool, Authenticate.AuthenticationError>) in
             showProgressView = false
                switch result {
                case .success:
                    if storeCredentialsNext {
                        if KeychainStorage.saveCredentials(credentials) {
                            storeCredentialsNext = false
                        }
                    }
                    completion(true)
                case .failure(let authError):
                    credentials = Credentials()
                    error = authError
                    completion(false)
                }
            }
        }
    }

