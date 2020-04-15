//
//  GameNew.swift
//  soccer1
//
//  Created by sam on 4/11/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameNew: View {
    @EnvironmentObject var appData: AppModel

    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @State private var gDate = Date()
    @State private var gHalf = 30
    @State private var gOpp = ""
    @State private var gLoc = ""
    
    var body: some View {
        VStack {
            Form {
                DatePicker(selection: $gDate,displayedComponents: .date, label: { Text("Game Date") })
                
                Stepper(value: $gHalf, in: 15...45) {
                    HStack {
                        Text("Half Length:")
                        Text(String(gHalf))
                    }
                }
                
                Spacer()
                TextField("Opponent", text: $gOpp)
                
                Spacer()
                TextField("Location", text: $gLoc)
            }
            // Buttons need to be outside the form becuase there is a bug where
            // all the buttons in the same row receive the tap gesture
            // https://bit.ly/2VjDULq
            HStack {
                Button(action: {()
                     self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }

                Spacer()
                
                Button(action: {
                    self.createNewGame()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            } .padding()
        }
    }

    private func createNewGame () {
        appData.games += [Game()]
        let i = appData.games.count
        appData.games[i-1].id = UUID()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        appData.games[i-1].gameDate = dateFormatter.string(from: gDate)
        appData.games[i-1].opponent = gOpp
        appData.games[i-1].location = gLoc
        appData.games[i-1].finalScore = ""
        appData.games[i-1].log = []
        for t in Team.allCases {
            for s in StatType.allCases {
                appData.games[i-1].stats.append(StatSummary(team: t, type: s, count: 0))
            }
        }
    }
}

struct GameNew_Previews: PreviewProvider {
    static var previews: some View {
        GameNew()
    }
}
