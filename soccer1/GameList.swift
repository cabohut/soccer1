//
//  GameList.swift
//  soccer1
//
//  Created by sam on 3/30/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameList: View {
    @EnvironmentObject private var appData: AppModel
    @State private var showHomeGamesOnly = false
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showHomeGamesOnly) {
                    Text("Home Games Only")
                }
                ForEach(appData.games) { game in
                    if !self.showHomeGamesOnly || (game.location == "Home") {
                        NavigationLink(destination: GameDetail(game: game)) {
                            GameRow(game: game)
                        }
                    }
                }
            }
            .navigationBarTitle("My Games")
            .navigationBarItems(trailing:
                Button(action: {})
                {
                    Image(systemName: "plus.square").imageScale(.large)
                })
        }
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 10"], id:\.self) { deviceName in
            GameList()
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
