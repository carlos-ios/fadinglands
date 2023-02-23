//
//  Authenticate.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/22/23.
//

import SwiftUI
import LocalAuthentication

class Authenticate: ObservableObject {
    @Published var isValidated = false
    @Published var isAuthorized = false
    enum BiometricType {
        case face
        case touch
        case none
    }
    enum AuthenticationError: Error, LocalizedError, Identifiable {
        case invalidCredentials
        case noFaceIdEnrolled
        case noFingerPrintEnrolled
        
        var id: String {
            self.localizedDescription
        }
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return NSLocalizedString("Email or Password is incorrect", comment: "Error 99")
            case .noFaceIdEnrolled:
                return NSLocalizedString("You have denied access to face id. please go to setting app to turn face ID on.", comment: "Error 99")
            case .noFingerPrintEnrolled:
                return NSLocalizedString("You have denied fingerprint access. please go to settings in the app to turn fingerprint on.", comment: "Error 99")
            }
        }
    }
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
    func biometricType() -> BiometricType {
        let authContext = LAContext()
        let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
        switch authContext.biometryType {
        case .none:
            return .none
        case .touchID:
            return .touch
        case .faceID:
            return .face
        @unknown default:
            fatalError("Error 9978")
        }
    }
}
