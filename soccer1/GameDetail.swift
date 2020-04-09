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
    
    @State private var showSummary = false
    
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
            
            Text("35:00")
                .font(.title)
            
            Text(currGame.gameDate)
            Spacer()
            
            Button(action: {self.appData.games[self.gameIndex].gameDate = getDateTime()}) {
                Text("Update Date")
            }
            
            ShowStatsButtons(gameIndex: self.gameIndex)
            Spacer()
            
            // Summary View
            Button(action: {
                self.showSummary.toggle()
            }) {
                Text("Show Game Log")
            } .sheet(isPresented: $showSummary) {
                // .environmentObject is needed becasue the sheet does not
                // inhirit appData from this view
                ShowSummary().environmentObject(self.appData)
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
