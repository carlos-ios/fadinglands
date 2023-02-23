//
//  Profile.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI

struct Profile: View {
    @State var signedOut = false
    @State var firstName = ""
    @EnvironmentObject var authenticate: Authenticate
    @Environment(\.managedObjectContext) var userInfo
    var body: some View {
        VStack {
            Text("YOU MADE IT")
            Spacer()
            Button("Log Out") {
                authenticate.updateValidation(success: false)
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
