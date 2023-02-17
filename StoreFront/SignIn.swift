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
    @State var email: String = ""
    @State var password: String = ""
    @State private var showingAlert = false
    @State var authenticate = Authenticate()
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
                                TextField("Email", text: $email).autocorrectionDisabled().textInputAutocapitalization(.never)
                                TextField("Password", text: $password).autocorrectionDisabled().textInputAutocapitalization(.never)
                            }
                            
                            
                            Button("Login") {
                                self.adminLogin()
                                do{
                                    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                                    var passwordObjects = [String]()
                                    var emailObjects = [String]()
                                    let results = try self.userInfo.fetch(fetchRequest)
                                    for result in results as [NSManagedObject]{

                                        if let theEmail = result.value(forKey: "email") as? String {
                                            emailObjects.append(theEmail)
                                        }
                                        if let thePassword = result.value(forKey: "password") as? String {
                                            passwordObjects.append(thePassword)
                                        }
                                        }
                                    authenticateLogin(anyEmail: emailObjects, anyPassword: passwordObjects)
                                    self.email = ""
                                    self.password = ""
                                    } catch {
                                    print("error")
                                }
                              
                                Authenticate()
                            }.alert(isPresented: $showingAlert) {
                                Alert(title: Text("Important Message"),
                                      message: Text("incorrect Login"),
                                      dismissButton: .default(Text("Error"))
                                )
                            }.foregroundColor(.red).scaledToFill()
                            NavigationLink(destination: Register()) {
                                Text("Register")
                            }.foregroundColor(.green)
                        }
                    }
                }
                
            }.navigationBarHidden(true)
    }
    private func adminLogin() {
        
        if self.email == "flashgod" && self.password == "123" {
            print("login successful")
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try self.userInfo.execute(deleteRequest)
                print("user data \(self.userInfo)")
            } catch let error as NSError {
                // TODO: handle the error
                print("delete failed \(error)")
            }
        }
    }
    
    private func authenticateLogin(anyEmail: [String], anyPassword: [String]) {
//        .filter({ $0.username == "user" && $0.password == "pass" }).first
        
        if anyEmail.description.contains(word: self.email){
            if anyPassword.description.contains(word: self.password) {
                print("entered email: ",self.email)
                print("entered password: ",self.password)
                print("login successful")
                authenticate.login()
                
            } else if self.password == "" {
                self.showingAlert = true
            }
                
        } else {
            self.showingAlert = true
            print("entered email: ",self.email)
            print("entered password: ",self.password)
            print("login unsuccessful")
        }
    }
}

struct firstScreen: View {
    @StateObject var authenticate = Authenticate()
    var body: some View {
        
            
        if authenticate.isLoggedin {
                    MainPage()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                } else {
                    SignIn(authenticate: authenticate)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
}

class Authenticate: ObservableObject {
    @Published var isLoggedin = false
    func login() {
        self.isLoggedin = true
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
