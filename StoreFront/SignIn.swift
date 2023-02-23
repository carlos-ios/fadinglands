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
                            
                            
                            Button("Login") {
                                self.adminLogin()
                                    do{
                                        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                                        var passwordObjects = [NSManagedObject]()
                                        var emailObjects = [NSManagedObject]()
                                        let results = try self.userInfo.fetch(fetchRequest)
                                        debugPrint("1::")
                                        viewmodel.login { success in
                                            authenticate.updateValidation(success: success)
                                        }
                                      

                                        self.viewmodel.credentials.email = ""
                                        self.viewmodel.credentials.password = ""
                                    } catch {
                                        print("error")
                                    }
                                
                            }.disabled(viewmodel.loginDisabled)
                                .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Important Message"),
                                      message: Text("incorrect Login"),
                                      dismissButton: .default(Text("Error"))
                                )
                                }.alert(item: $viewmodel.error) { error in
                                Alert(title: Text("Important Message"),
                                      message: Text("Email or Password is incorrect"),
                                      dismissButton: .default(Text("Ok"))
                                )
                            }.foregroundColor(.red).scaledToFill()
                            .onTapGesture {
                                    UIApplication.shared.endEditing()
                                }
                            NavigationLink(destination: Register()) {
                                Text("Register")
                            }.foregroundColor(.green)
                        }
                    }
                }
                
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
