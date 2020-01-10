//
//  SignUpView.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 1/2/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SignUpView: View {
    @State private var userName = ""
    @State private var passWord = ""
    
    @State private var signUp = false
    
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            Text("Sign Up").bold().font(.system(size: 50))
            Spacer()
            TextField("Enter username here", text: $userName)
            Spacer()
            TextField("Enter password here", text: $passWord)
            Spacer()
            Button(action: {
                Auth.auth().createUser(withEmail: self.userName, password: self.passWord) { (result, error) in
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": self.userName, "password": self.passWord]
                    
                    Database.database().reference().child("Current_Users").child(uid).updateChildValues(values as [AnyHashable:Any], withCompletionBlock: { (error, ref) in
                        if let error = error {
                            print("Something went wrong... \(error.localizedDescription)")
                            return
                        }
                    })
                }
            }) {
                Text("Sign Up")
            }.sheet(isPresented: $signUp) {
                SignInView()
            }
            Text(self.errorMessage)
        }.padding()
    }
}
