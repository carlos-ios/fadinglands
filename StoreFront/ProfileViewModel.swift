//
//  ProfileViewModel.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/21/23.
//

import Foundation
import Combine
import CoreData

class ProfileViewModel {
    var context = PersistenceController.shared.container.viewContext
    func fetchProfileData() {
        var profileData = [User]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            
            let profile = try context.execute(fetchRequest)
           print("profile data \(profile)")
               // Then you can use your properties.

             
        } catch {
            
        }
        
    }
}
