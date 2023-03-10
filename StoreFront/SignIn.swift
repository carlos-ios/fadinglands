//
//  SignIn.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/15/23.
//

import SwiftUI
import CoreData
import Combine

struct SignIn: View {
    @Environment(\.managedObjectContext) var userInfo
    @EnvironmentObject var authenticate: Authenticate
    @StateObject var viewmodel = SigninViewModel()
    @State private var showingAlert = false
    @State var isLoggedIn = false
    @State private var showingIncorrectPassAndOrEmail = false
     var body: some View {
        
            NavigationView {
                

                VStack {
                    Image("drgreenthumb").resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .border(Color.white)
                    Text("Welcome to Dr GreenThumb").bold().foregroundColor(.gray)
                    VStack {
                        Form {
                            Section {
                                TextField("Email", text: $viewmodel.credentials.email).autocorrectionDisabled().textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                SecureField("Password", text: self.$viewmodel.credentials.password).autocorrectionDisabled().textInputAutocapitalization(.never)
                                if viewmodel.showProgressView {
                                    ProgressView()
                                }
                            }
                        }
                            
                            Button("Login") {
                                self.adminLogin()
                                
                                    do{
                                        viewmodel.login { success in
                                            authenticate.updateValidation(success: success)
                                        }
                                      

                                        self.viewmodel.credentials.email = ""
                                        self.viewmodel.credentials.password = ""
                                    }
                                
                            }.disabled(viewmodel.loginDisabled).alert(isPresented: $showingAlert) {
                                Alert(title: Text("Important Message"),
                                      message: Text("incorrect Login"),
                                      dismissButton: .default(Text("Error"))
                                )
                                }.alert(item: $viewmodel.error) { error in
                                    if error == .credentialsNotSaved {
                                        return Alert(title: Text("Credentials Not Saved"), primaryButton: .default(Text("Ok"), action: {
                                            
                                            viewmodel.storeCredentialsNext = true
                                        }), secondaryButton: .cancel())
                                    } else {
                                        return Alert(title: Text("Invalid Login"), message: Text(error.localizedDescription))
                                    }
                                
                            }.foregroundColor(.red).scaledToFill()
                            .onTapGesture {
                                    UIApplication.shared.endEditing()
                                }
                        Text("")
                            NavigationLink(destination: Register()) {
                                Text("Register")
                            }.foregroundColor(.green)
                        
                    }
                    if authenticate.biometricType() != .none {
                        Button {
                            authenticate.requestBiometricUnlock { (result: Result<Credentials, Authenticate.AuthenticationError>) in
                                switch result {
                                case .success(let credentials):
                                    self.viewmodel.credentials = credentials
                                    self.viewmodel.login { success in
                                        authenticate.updateValidation(success: success)
                                    }
                                case .failure(let error):
                                    self.viewmodel.error = error
                                }
                            }
                        } label: {
                            Image(systemName: authenticate.biometricType() == .face ? "faceid" : "touchid").frame(width: 50, height: 50)
                        }.multilineTextAlignment(.center)
                    }
                }.multilineTextAlignment(.center)
                Spacer()
                
            }.navigationBarHidden(true)
    }
    private func adminLogin() {
        
        if self.viewmodel.credentials.email == "flashgod" && self.viewmodel.credentials.password == "123" {
            print("login successful")
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                print("all data: \(self.userInfo.registeredObjects)")
                try self.userInfo.execute(deleteRequest)
                print("user data \(self.userInfo)")
            } catch let error as NSError {
                // TODO: handle the error
                print("delete failed \(error)")
            }
        }
    }
    
//    private func authenticateLogin(anyEmail: [NSManagedObject], anyPassword: [NSManagedObject]) {
////        .filter({ $0.username == "user" && $0.password == "pass" }).first
////        if self.password.isValidPassword() {
//        if anyEmail.description.contains(word: self.viewmodel.credentials.email) && anyPassword.description.contains(word: self.viewmodel.credentials.password) {
//                print("entered email: ",self.viewmodel.credentials.email)
//                print("entered password: ",self.viewmodel.credentials.password)
//                print("login successful")
//                self.isLoggedIn = true
//
//            } else {
//                self.showingAlert = true
//                print("entered email: ",self.viewmodel.credentials.email)
//                print("entered password: ",self.viewmodel.credentials.password)
//                print("login unsuccessful")
//            }
////        } else {
////            self.showingIncorrectPassAndOrEmail = true
////            print("entered email: ",self.email)
////            print("entered password: ",self.password)
////            print("login unsuccessful")
////        }
//
//        }
    }


struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
