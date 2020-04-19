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
    @State private var addGame = false
    @State private var editMode = EditMode.inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(appData.games) { game in
                    NavigationLink(destination: GameDetail(gameID: game.id)) {
                        GameRow(game: game)
                    } .frame(height: 50)
                }   .onDelete(perform: onDelete)
                    .onMove(perform: onMove(source:destination:))
            }
            .navigationBarTitle("My Games", displayMode: .inline)
            .navigationBarItems(leading: EditButton().font(.headline), trailing:
                Button(action: {self.addGame.toggle()}) {
                    if !editMode.isEditing {
                        //Image(systemName: "plus").font(.headline)
                        Text("Add Game").font(.headline)
                    }
                }
                .sheet(isPresented: $addGame) {
                    GameNew().environmentObject(self.appData)
                    // .environmentObject is needed becasue appData is not inhirited
                })
            .environment(\.editMode, $editMode)
        }
    }
    
    private func onDelete(at offsets: IndexSet) {
        appData.games.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        appData.games.move(fromOffsets: source, toOffset: destination)
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
