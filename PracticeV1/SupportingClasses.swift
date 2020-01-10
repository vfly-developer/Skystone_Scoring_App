//
//  SupportingClasses.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 1/2/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    // Main Screen Data
    @Published var teamName = ""
    @Published var teamNum = ""
    @Published var event = ""
    @Published var scorer = ""
    @Published var round = ""
    @Published var mechanism = ""
    // Autonomous Phase Data
    @Published var zone = false
    @Published var red = false
    @Published var foundationMovedAuto = false
    @Published var parkingAuto = false
    
    @Published var skystonesAuto = 0
    @Published var stonesAuto = 0
    @Published var placingAuto = 0
    @Published var timeAuto = 0
    @Published var foundationTimeAuto = 0
    //Tele-Op Data
    @Published var deliveredTeleOp = 0
    @Published var placingTeleOp = 0
    @Published var skyscraperTeleOp = 0
    //End Game Data
    @Published var capstonesEndGame = 0
    
    @Published var firstCapstoneEndGame = ""
    @Published var secondCapstoneEndGame = ""
    
    @Published var foundationMovedEndGame = false
    @Published var parkingEndGame = false
    // Calculations
    @Published var scoreAuto = 0
    @Published var scoreTeleOp = 0
    @Published var scoreEndGame = 0
    
    func getAllData() -> String {
        var returnString = ""
        returnString += "This is from the sign in view: \(teamName), \(teamNum), \(event), \(scorer), \(round), \(mechanism)"
        returnString += "\nThis is from the autonomous view: \(zone), \(red), \(foundationMovedAuto), \(parkingAuto), \(skystonesAuto), \(stonesAuto), \(placingAuto), \(timeAuto), \(foundationTimeAuto)"
        returnString += "\nThis is from the teleop view: \(deliveredTeleOp), \(placingTeleOp), \(skyscraperTeleOp)"
        returnString += "\nThis is from the endgame view: \(capstonesEndGame), \(firstCapstoneEndGame), \(secondCapstoneEndGame), \(foundationMovedEndGame), \(parkingEndGame)"
        return returnString
    }
}
