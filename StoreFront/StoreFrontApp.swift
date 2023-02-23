//
//  StoreFrontApp.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI

@main
struct StoreFrontApp: App {
    @StateObject var authenticate = Authenticate()
    let persistenceController = PersistenceController.shared

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
