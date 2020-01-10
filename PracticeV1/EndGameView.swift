//
//  InGamePage.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 1/1/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct EndGameView: View {
    
    @State private var foundationMoved = false
    @State private var parking = false
    
    @State private var capstones = 0
    
    @State private var firstCapstone = ""
    @State private var secondCapstone = ""
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            HStack {
                Text("Capstones \(capstones)")
                Button(action: {
                    self.capstones = self.capstones + 1
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.capstones>0) {
                        self.capstones = self.capstones - 1
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("First Capstone: ")
                TextField("", text: $firstCapstone)
            }.padding()
            HStack {
                Text("Second Capstone: ")
                TextField("", text: $secondCapstone)
            }.padding()
            HStack {
                Spacer()
                Text("Foundation Moved")
                Toggle(isOn: $foundationMoved) {
                    Text("")
                }.frame(width:60)
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Text("Parking")
                Toggle(isOn: $parking) {
                    Text("")
                }.frame(width:60)
                Spacer()
            }.padding()
            Button(action: {
                //print("Placeholder for now until I can export data to excel sheet")
                self.settings.capstonesEndGame = self.capstones
                self.settings.firstCapstoneEndGame = self.firstCapstone
                self.settings.secondCapstoneEndGame = self.secondCapstone
                self.settings.foundationMovedEndGame = self.foundationMoved
                self.settings.parkingEndGame = self.parking
                
                self.calcAutonomousScore()
                self.calcTeleOpScore()
                self.calcEndGameScore()
                
                let totalScore = self.settings.scoreAuto + self.settings.scoreTeleOp + self.settings.scoreEndGame
                
                let valuesAuto = ["Autonomous Score": self.settings.scoreAuto, "Autonomous Time": self.settings.timeAuto, "Foundation Moved": self.settings.foundationMovedAuto, "Foundation Time": self.settings.foundationTimeAuto, "Parked": self.settings.parkingAuto, "Skystones Delivered": self.settings.skystonesAuto, "Stones Delivered": self.settings.stonesAuto, "Total Stones Placed": self.settings.placingAuto] as [String : Any]

                let valuesTeleOp = ["Skyscraper Height": self.settings.skyscraperTeleOp, "TeleOp Score": self.settings.scoreTeleOp, "TeleOp Stones Delivered": self.settings.deliveredTeleOp, "TeleOp Stones Placed": self.settings.placingTeleOp] as [String : Any]
               
                let valuesEndGame = ["Capstones Placed": self.settings.capstonesEndGame, "Endgame Score": self.settings.scoreEndGame, "First Capstone Height": self.settings.firstCapstoneEndGame, "Foundation Moved Out": self.settings.foundationMovedEndGame, "Parked Endgame": self.settings.parkingEndGame, "Second Capstone Height": self.settings.secondCapstoneEndGame, "Total Score": totalScore] as [String : Any]
                
                let valuesGeneral = ["Event Name": self.settings.event, "Scorer": self.settings.scorer, "Team Name": self.settings.teamName, "Team Number": self.settings.teamNum] as [String : Any]
                Database.database().reference().child("data").child(self.settings.teamName).child("Round \(self.settings.round)").child("Autonomous").updateChildValues(valuesAuto as [AnyHashable:Any])
                Database.database().reference().child("data").child(self.settings.teamName).child("Round \(self.settings.round)").child("Endgame").updateChildValues(valuesEndGame as [AnyHashable:Any])
                Database.database().reference().child("data").child(self.settings.teamName).child("Round \(self.settings.round)").child("Info").updateChildValues(valuesGeneral as [AnyHashable:Any])
                Database.database().reference().child("data").child(self.settings.teamName).child("Round \(self.settings.round)").child("TeleOp").updateChildValues(valuesTeleOp as [AnyHashable:Any])
                
            }) {
                Text("Submit Data")
            }.padding()
        }.padding()
    }
    func calcAutonomousScore() {
        self.settings.scoreAuto += self.settings.foundationMovedAuto ? 10:0
        self.settings.scoreAuto += self.settings.parkingAuto ? 5:0
        self.settings.scoreAuto += self.settings.skystonesAuto*10
        self.settings.scoreAuto += self.settings.stonesAuto*2
        self.settings.scoreAuto += self.settings.placingAuto*4
    }
    func calcTeleOpScore() {
        self.settings.scoreTeleOp += self.settings.deliveredTeleOp
        self.settings.scoreTeleOp += self.settings.placingTeleOp
        self.settings.scoreTeleOp += self.settings.skyscraperTeleOp
    }
    func calcEndGameScore() {
        self.settings.scoreEndGame += self.settings.foundationMovedEndGame ? 15:0
        self.settings.scoreEndGame += self.settings.parkingEndGame ? 5:0
        self.settings.scoreEndGame += self.settings.capstonesEndGame*5
        self.settings.scoreEndGame += Int(self.settings.firstCapstoneEndGame) ?? 0
        self.settings.scoreEndGame += Int(self.settings.secondCapstoneEndGame) ?? 0
    }
}
