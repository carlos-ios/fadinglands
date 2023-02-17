//
//  Register.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/14/23.
//

import SwiftUI
import CoreData
import OSLog

struct Register: View {
//    @FetchRequest(fetchRequest: Registration.fetchRequest()) var registration: FetchedResults<Registration>
    @Environment(\.managedObjectContext) private var userInfo
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showingAlert = false
    @State var passwordAlert = false
    var logger = Logger()
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
                            TextField("First Name", text: $firstName).autocorrectionDisabled().textInputAutocapitalization(.never)
                            TextField("Last Name", text: $lastName).autocorrectionDisabled().textInputAutocapitalization(.never)
                            TextField("Email", text: $email).autocorrectionDisabled().textInputAutocapitalization(.never)
                            TextField("Password", text: $password).autocorrectionDisabled().textInputAutocapitalization(.never)
                        }
                        Button("Submit") {
                            let registrationInfo = NSEntityDescription.insertNewObject(forEntityName: "User", into: self.userInfo) as! User
                            if !self.email.contains(word: "@") {
                                self.showingAlert = true
                            }
                            if self.password.count < 5 {
                                self.passwordAlert = true
                            }
                            registrationInfo.firstName = self.firstName
                            registrationInfo.lastName = self.lastName
                            registrationInfo.lastName = self.lastName
                            registrationInfo.email = self.email
                            registrationInfo.password = self.password
                            do {
                                if self.userInfo.hasChanges && showingAlert != true && passwordAlert != true {
                                    try PersistenceController.shared.container.viewContext.save()
                                    self.email = ""
                                    self.firstName = ""
                                    self.lastName = ""
                                    self.password = ""
                                    logger.log("New data has been saved successfully")
                                } else {
                                    logger.log("No data submitted")
                                }
                            } catch {
                                logger.log("Unable to save registration data: \(error.localizedDescription)")
                            }
                            //                UITextField.appearance().text = ""
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Registration Error Message"),
                                  message: Text("Email in incorrect format"),
                                  dismissButton: .default(Text("Error unable to submit"))
                            )
                        }.alert(isPresented: $passwordAlert) {
                            Alert(title: Text("Password Error Message"),
                                  message: Text("Password must be longer than 5 characters"),
                                  dismissButton: .default(Text("Unable to submit"))
                            )
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
//    var disableForm: Bool {
//        email.count < 5 || password.count < 5
//    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
