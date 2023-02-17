//
//  StoreFrontApp.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI

@main
struct StoreFrontApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            firstScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
