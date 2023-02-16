//
//  Register.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI
import CoreData

struct Register: View {
//    @FetchRequest(fetchRequest: Registration.fetchRequest()) var registration: FetchedResults<Registration>
    @Environment(\.managedObjectContext) private var userInfo
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    let context = PersistenceController.shared.container.viewContext
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("We're happy to see you!").bold().foregroundColor(.black)
                    Text("")
                    Text("Register below...").italic()
                }
                VStack {
                    Form {
                        Section {
                            TextField("First Name", text: $firstName).autocorrectionDisabled()
                            TextField("Last Name", text: $lastName).autocorrectionDisabled()
                            TextField("Email", text: $email).autocorrectionDisabled()
                            TextField("Password", text: $password).autocorrectionDisabled()
                        }
                        Button("Submit") {
                            let registrationInfo = User(context: self.userInfo)
                            registrationInfo.firstName = self.firstName
                            registrationInfo.lastName = self.lastName
                            registrationInfo.lastName = self.lastName
                            registrationInfo.email = self.email
                            registrationInfo.password = self.password
                            do {
                                if self.userInfo.hasChanges {
                                    try PersistenceController.shared.container.viewContext.save()
                                    
                                    print(self.userInfo.registeredObjects)
                                    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                                    print(try self.userInfo.fetch(fetchRequest))
                                } else {
                                    print("No changes detected")
                                }
                            } catch {
                                print(error.localizedDescription)
                            }
                            //                UITextField.appearance().text = ""
                        }
                        NavigationLink(destination: SignIn()){
                            Text("Login")
                        }.foregroundColor(.green)
                    }
                    
                }
            }
            //        }.disabled(disableForm)
        }.navigationBarHidden(true)
            .navigationTitle("")
    }
    var disableForm: Bool {
        email.count < 5 || password.count < 5
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
