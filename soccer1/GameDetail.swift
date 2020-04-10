//
//  GameDetail.swift
//  soccer1
//
//  Created by sam on 3/25/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameDetail: View {
    @EnvironmentObject var appData: AppModel
    
    @State private var showLog = false
    @State private var selectTeam: Team = .us
    
    var game: Game

    // gameIndex will be used to acccess or update the model
    var gameIndex: Int {
        appData.games.firstIndex(where: { $0.id == game.id})!
    }
    var currGame: Game {
        self.appData.games[self.gameIndex]
    }

    var body: some View {

        VStack (spacing: 25) {
            HStack {
                Button(action: {self.appData.gameState.half = .first}) {
                    Text("Start Game")
                }
                Spacer()
                Button(action: {self.appData.gameState.half = .second}) {
                    Text("Start 2nd Half")
                }
            }
            
            // Timer
            Text("35:00")
                .font(.title)

            Spacer()
            
            // Test button
            Button(action: {self.appData.games[self.gameIndex].opponent = "Me"}) {
                Text("Update Oponent")
            }
            
            // Stats buttons
            ShowStatsButtons(gameIndex: self.gameIndex)
             
            // Us or Them selector
            Picker("", selection: $appData.gameState.team) {
                Text("Us").tag(Team.us)
                Text("Them").tag(Team.them)
            } .padding()
            .pickerStyle(SegmentedPickerStyle())

            Spacer()
            
            // Summary View
            Button(action: {
                self.showLog.toggle()
            }) {
                Text("Show Game Log")
            } .sheet(isPresented: $showLog) {
                // .environmentObject is needed becasue the sheet does not
                // inhirit appData from this view
                ShowLog().environmentObject(self.appData)
            }
        }
        .padding()
        .navigationBarTitle(game.opponent)
    }
}

#if DEBUG
struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11"], id:\.self) { deviceName in
            GameDetail(game: gameData[0])
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
#endif
