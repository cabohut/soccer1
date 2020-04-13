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
    @State var addGame = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(appData.games) { game in
                    NavigationLink(destination: GameDetail(game: game)) {
                        GameRow(game: game)
                    }
                }
            }
            .navigationBarTitle("My Games")
            .navigationBarItems(trailing:
                Button(action: {self.addGame.toggle()}) {
                    Image(systemName: "plus").imageScale(.large)
                    }
                    .sheet(isPresented: $addGame) {
                    GameNew().environmentObject(self.appData)
                    // .environmentObject is needed becasue appData is not inhirited
                }
            )
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
