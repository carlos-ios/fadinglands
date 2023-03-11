//
//  StoreFrontApp.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI
import Firebase
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      Messaging.messaging().delegate = self

              if #available(iOS 10.0, *) {
                // For iOS 10 display notification (sent via APNS)
                UNUserNotificationCenter.current().delegate = self

                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                  options: authOptions,
                  completionHandler: {_, _ in })
              } else {
                let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                application.registerUserNotificationSettings(settings)
              }

              application.registerForRemoteNotifications()
    return true
  }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

         if let messageID = userInfo[gcmMessageIDKey] {
           print("Message ID: \(messageID)")
         }

         print(userInfo)

         completionHandler(UIBackgroundFetchResult.newData)
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
