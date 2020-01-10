//
//  InGameview.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 12/30/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct InGameView: View {
    @State private var inGame = false
    @State private var inGame1 = false
    @State private var inGame2 = false
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        TabView {
            AutonomousView().environmentObject(self.settings)
            .tabItem {
                Text("Autonomous")
            }.tag(0)
            TeleOpView().environmentObject(self.settings)
            .tabItem {
                Text("Tele-Op")
            }.tag(1)
            EndGameView().environmentObject(self.settings)
            .tabItem {
                Text("End Game")
            }.tag(2)
        }
    }
}
