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
    @State var emailAlert = false
    @State var passwordAlertcontent = false
    @State var validEmail = false
    @State var validPassword = false
    @State var submitted = false
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
                            
                            
                            
                            if self.viewmodel.credentials.email.isValidEmail() && self.viewmodel.credentials.password.isValidPassword() {
                                DispatchQueue.main.async {
                                    var credentials = Credentials()
                                    
                                    credentials.email = viewmodel.credentials.email
                                    credentials.password = viewmodel.credentials.password
                                    viewmodel.storeCredentialsNext = true
                                    if KeychainStorage.saveCredentials(credentials) {
                                        viewmodel.storeCredentialsNext = false
                                    }
                                }
                                
                                self.submitted = true
                                self.viewmodel.credentials.email = ""
                                self.viewmodel.credentials.password = ""
                            } else {
                                self.passwordAlertcontent = true
                            }
                            
                            //
                            self.submitted = true
                            //                UITextField.appearance().text = ""
                        }.alert(isPresented: $passwordAlertcontent) {
                            Alert(title: Text("Registration Error Message"),
                                  message: Text("Email must be valid and Password must be atleast 5 Characters Long Contain a Capital Letter and One Special Character"),
                                  dismissButton: .default(Text("Unable to submit"))
                            )
                        }
                    }
                    
                }.alert(isPresented: $submitted) {
                    Alert(title: Text("Congrats!"),
                          message: Text("We got you locked in fam."),
                          dismissButton: .default(Text("Go Time"))
                    )
                }
                //        }.disabled(disableForm)
            }.navigationBarHidden(false)
        }
        //    var disableForm: Bool {
        //        email.count < 5 || password.count < 5
        //    }
    }
    
    
}
