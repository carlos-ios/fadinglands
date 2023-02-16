//
//  SignIn.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/15/23.
//

import SwiftUI
import CoreData

struct SignIn: View {
    @Environment(\.managedObjectContext) var userInfo
    @State var email: String = ""
    @State var password: String = ""
    @State private var showingAlert = false
    let context = PersistenceController.shared.container.viewContext
    
    var body: some View {
        let user = User(context: self.userInfo)
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
                                TextField("Email", text: $email).autocorrectionDisabled()
                                TextField("Password", text: $password).autocorrectionDisabled()
                            }
                            
                            
                            Button("Login") {
                                self.authenticateLogin()
                                do{
                                    let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
                                    
                                    let results = try context.fetch(fetchRequest)
                                    for result in results as [NSManagedObject]{
                                        print("fetch data1 \(result)")
                                       
                                        }
                                        
                                    } catch {
                                    print("error")
                                }
                              
                                
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
    private func authenticateLogin() {
        if self.email == "flashgod" && self.password == "123" {
            print("login successful")
            
        }
    }
}
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
