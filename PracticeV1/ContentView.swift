//
//  ContentView.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 12/30/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    
    @State var databaseHandler:DatabaseHandle?
    var mechanisms: [String] = ["Forklift", "Intake Wheel"]
    
    @State private var mechanism = 0
    
    @State private var teamNameTF = ""
    @State private var teamNumberTF = ""
    @State private var eventTF = ""
    @State private var scorerTF = ""
    @State private var roundTF = ""
    
    @State private var inGame = false
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pioneer Robotics").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity).background(Color.red)
                HStack {
                    Text("Team Name: ")
                    TextField("", text: $teamNameTF) {
                        self.inGame = false
                    }
                }.frame(minHeight: 85)
                HStack {
                    Text("Team Number: ")
                    TextField("", text: $teamNumberTF) {
                        self.inGame = false
                    }
                }.frame(minHeight: 85)
                HStack {
                    Text("Event: ")
                    TextField("", text: $eventTF) {
                        self.inGame = false
                    }
                }.frame(minHeight: 85)
                HStack {
                    Text("Scorer: ")
                    TextField("", text: $scorerTF) {
                        self.inGame = false
                    }
                }.frame(minHeight: 85)
                HStack {
                    Text("Round: ")
                    TextField("", text: $roundTF) {
                        self.inGame = false
                    }
                }.frame(minHeight: 85)
                HStack {
                    Text("Grabbing Mechanism: ")
                    Picker(selection: $mechanism, label: Text("")) {
                        Text("Forklift").tag(0)
                        Text("Intake Wheel").tag(1)
                    }.frame(width: 170).padding()
                }.frame(minHeight: 85)
                NavigationLink(destination: InGameView().environmentObject(self.settings), isActive: self.$inGame) {
                    Text("")
                }
                Button("Submit") {
                    
                    var teamNames = [String]()
                    
                    self.inGame = true
                    
                    self.settings.teamName = self.teamNameTF
                    self.settings.teamNum = self.teamNumberTF
                    self.settings.event = self.eventTF
                    self.settings.scorer = self.scorerTF
                    self.settings.round = self.roundTF
                    self.settings.mechanism = self.mechanisms[self.mechanism]
                    
                    self.databaseHandler = Database.database().reference().child("events").observe(.childAdded, with: { (snapshot) in
                        if snapshot.key == self.settings.event {
                            for child in snapshot.children.allObjects as! [DataSnapshot] {
                                teamNames.append(child.childSnapshot(forPath: "Team Name").value as! String)
                                //print(child.childSnapshot(forPath: "Team Name").value as! String)
                                if !(teamNames.contains(self.settings.teamName)) {
                                    let values = ["Event": self.settings.event, "Team Name": self.settings.teamName, "Team Number": self.settings.teamNum]
                                    Database.database().reference().child("events").child(self.settings.event).child(self.settings.teamName).updateChildValues(values as [AnyHashable:Any])
                                }
                            }
                        }
                    })
                }
            }.padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
