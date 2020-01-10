//
//  AutonomousView.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 12/31/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import FirebaseDatabase

struct AutonomousView: View {
    
    @State private var zone = false
    @State private var side = false
    @State private var foundation = false
    @State private var parking = false
    @State private var timeStopped = false
    @State private var foundationTimeStarted = false
    @State private var foundationTimeStopped = false
    
    @State private var run = true
    
    @State private var skystoneNum = 0
    @State private var stoneNum = 0
    @State private var placingNum = 0
    @State private var foundationTime = 0
    @State private var time = 0
    
    @State private var maxTime = 30
    
    @EnvironmentObject var settings: UserSettings
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                Text("Building")
                Toggle(isOn: self.$settings.zone) {
                    Text("")
                }.frame(width:60)
                Text("Loading")
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Text("Red")
                Toggle(isOn: self.$settings.red) {
                    Text("")
                }
                .frame(width:60)
                Text("Blue")
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Text("Foundation Moved")
                Toggle(isOn: self.$settings.foundationMovedAuto) {
                    Text("")
                }.frame(width:60)
                Spacer()
            }.padding()
            HStack {
                Spacer()
                Text("Parking")
                Toggle(isOn: self.$settings.parkingAuto) {
                    Text("")
                }.frame(width:60)
                Spacer()
            }.padding()
            HStack {
                Text("Skystones \(self.skystoneNum)")
                Button(action: {
                    self.skystoneNum = self.skystoneNum + 1
                    self.settings.skystonesAuto = self.skystoneNum
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.skystoneNum>0) {
                        self.skystoneNum = self.skystoneNum - 1
                        self.settings.skystonesAuto = self.skystoneNum
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("Stones \(self.stoneNum)")
                Button(action: {
                    self.stoneNum = self.stoneNum + 1
                    self.settings.stonesAuto = self.stoneNum
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.stoneNum>0) {
                        self.stoneNum = self.stoneNum - 1
                        self.settings.stonesAuto = self.stoneNum
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("Placing \(self.placingNum)")
                Button(action: {
                    self.placingNum = self.placingNum + 1
                    self.settings.placingAuto = self.placingNum
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.placingNum>0) {
                        self.placingNum = self.placingNum - 1
                        self.settings.placingAuto = self.placingNum
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("Autonomous Time: \(time)")
                    .onReceive(timer) { _ in
                        if self.time < self.maxTime && self.timeStopped == false {
                            self.time += 1
                        }
                }
                Button(action: {
                    self.timeStopped = true
                    self.settings.timeAuto = self.time
                }) {
                    Text("Stop")
                }
            }.padding()
            HStack {
                Text("Foundation Time: \(foundationTime)")
                    .onReceive(timer) { _ in
                        if self.timeStopped == false && self.foundationTimeStarted == true && self.foundationTimeStopped == false && self.foundationTime<self.maxTime{
                            self.foundationTime += 1
                        }
                }
                Button(action: {
                    self.foundationTimeStarted = true
                }) {
                    Text("Start")
                }
                Button(action: {
                    self.foundationTimeStopped = true
                    self.settings.foundationTimeAuto = self.foundationTime
                }) {
                    Text("Stop")
                }
            }.padding()
        }.padding()
    }
}
