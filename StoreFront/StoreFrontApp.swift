//
//  StoreFrontApp.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct StoreFrontApp: App {
    @StateObject var authenticate = Authenticate()
    let persistenceController = PersistenceController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if authenticate.isValidated {
                MainPage().environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authenticate)
            } else {
                SignIn().environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(authenticate)
            }
            
        }
    }
}
