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
    @StateObject var viewmodel = SigninViewModel()
//    @State var firstName: String
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
//    @State var lastName: String = ""
//    @Binding var email: String
//    @State var password: String
    @State var showingAlert = false
    @State var passwordAlertlength = false
    @State var passwordAlertcontent = false
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
//                            TextField("First Name", text: $firstName).autocorrectionDisabled().textInputAutocapitalization(.never)
//                            TextField("Last Name", text: $lastName).autocorrectionDisabled().textInputAutocapitalization(.never)
                            TextField("Email", text: $viewmodel.credentials.email).autocorrectionDisabled().textInputAutocapitalization(.never)
                            TextField("Password", text: $viewmodel.credentials.password).autocorrectionDisabled().textInputAutocapitalization(.never)
                        }
                        Button("Submit") {
//                            var registrationInfo = NSEntityDescription.insertNewObject(forEntityName: "User", into: self.userInfo) as! User
                            var credentials = Credentials()
//                            if !self.email.contains(word: "@") {
//                                self.showingAlert = true
//                            }
//                            if self.password.count < 5 {
//                                self.passwordAlertlength = true
//                            }
//                            if !self.password.isValidPassword() {
//                                self.passwordAlertcontent = true
//                            }
//
                            credentials.email = viewmodel.credentials.email
                            credentials.password = viewmodel.credentials.password
                            viewmodel.storeCredentialsNext = true
                            if KeychainStorage.saveCredentials(credentials) {
                                viewmodel.storeCredentialsNext = false
                                self.email = ""
                                self.password = ""
                            }
                            self.email = ""
                            self.password = ""
                            //                UITextField.appearance().text = ""
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text("Registration Error Message"),
                                  message: Text("Email in incorrect format"),
                                  dismissButton: .default(Text("Error unable to submit"))
                            )
                        }.alert(isPresented: $passwordAlertlength) {
                            Alert(title: Text("Password Error Message"),
                                  message: Text("Password must be longer than 5 characters"),
                                  dismissButton: .default(Text("Unable to submit"))
                            )
                        }.alert(isPresented: $passwordAlertcontent) {
                            Alert(title: Text("Password Error Message"),
                                  message: Text("Password must contain a capital and one special character"),
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


