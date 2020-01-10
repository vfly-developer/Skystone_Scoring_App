//
//  TeleOpView.swift
//  PracticeV1
//
//  Created by Vinh Nguyen on 1/1/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct TeleOpView: View {
    
    @State private var delivered = 0
    @State private var placed = 0
    @State private var skyscraper = 0
    
    @EnvironmentObject var settings: UserSettings
    
    var body: some View {
        VStack {
            HStack {
                Text("Delivered \(delivered)")
                Button(action: {
                    self.delivered = self.delivered + 1
                    self.settings.deliveredTeleOp = self.delivered
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.delivered>0) {
                        self.delivered = self.delivered - 1
                        self.settings.deliveredTeleOp = self.delivered
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("Placed \(placed)")
                Button(action: {
                    self.placed = self.placed + 1
                    self.settings.placingTeleOp = self.placed
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.placed>0) {
                        self.placed = self.placed - 1
                        self.settings.placingTeleOp = self.placed
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
            HStack {
                Text("Skyscraper \(skyscraper)")
                Button(action: {
                    self.skyscraper = self.skyscraper + 1
                    self.settings.skyscraperTeleOp = self.skyscraper
                }) {
                    Image(systemName: "plus")
                }
                Button(action: {
                    if(self.skyscraper>0) {
                        self.skyscraper = self.skyscraper - 1
                        self.settings.skyscraperTeleOp = self.skyscraper
                    }
                }) {
                    Image(systemName: "minus")
                }
            }.padding()
        }.padding()
    }
}
