//
//  LogInView.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 1/2/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SignInView: View {
    @State private var userName = ""
    @State private var passWord = ""
    
    @State private var errorMessage = ""
    
    @State private var signUp = false
    @State private var signIn = false
    
    @EnvironmentObject private var settings: UserSettings
    
    var handle: AuthStateDidChangeListenerHandle? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign In").bold().font(.system(size: 50))
                Spacer()
                TextField("Enter username here", text: $userName)
                Spacer()
                TextField("Enter password here", text: $passWord)
                Button(action: {
                    Database.database().isPersistenceEnabled = true
                    let email = self.userName
                    let password = self.passWord
                    
                    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                        if let error = error {
                            print(error.localizedDescription)
                            self.errorMessage = error.localizedDescription
                            return
                        }
                    }
                    self.signIn = true
                }) {
                    Text("Sign In")
                    }.sheet(isPresented: $signIn) {
                    ContentView().environmentObject(self.settings)
                }
                Spacer()
                HStack {
                    Text("Wanna sign up? (*psst* DONT) ")
                    Button("Sign Up") {
                        self.signUp = true
                    }.sheet(isPresented: $signUp) {
                        SignUpView()
                    }
                }
                Text(self.errorMessage).frame(minHeight: 60)
                Spacer()
            }.padding()
        }
    }
}
