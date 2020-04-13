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
            
            Spacer()
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                Spacer()
                Button(action: {
                    self.createNewGame()
                }) {
                    Text("Save")
                }
            }
        }
    }
    
    private func createNewGame () {

        appData.games += [Game()]
        let i = appData.games.count
        print(appData.games[i-2])
        appData.games[i-1].id = i
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        appData.games[i-1].gameDate = dateFormatter.string(from: gDate)
        appData.games[i-1].opponent = gOpp
        appData.games[i-1].location = gLoc
        appData.games[i-1].finalScore = ""
        appData.games[i-1].log = []
//        for t in Team.allCases {
//            appData.games[i-1].stats.append()
//        }
//            for s in StatType.allCases {
//                print(t, s)
//                appData.games[i-1].stats[t]?[s] = 0
//            }
//        }
        print(appData.games[i-1])
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct GameNew_Previews: PreviewProvider {
    static var previews: some View {
        GameNew()
    }
}
