//
//  GameDetail.swift
//  soccer1
//
//  Created by sam on 3/25/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameDetail: View {
    var gameID: UUID
    
    @EnvironmentObject var appData: AppModel
    @State var elapsedSeconds: Int = 0
    @State private var showLog = false

    // gameIndex will be used to acccess or update the model
    var gameIndex: Int {
        appData.games.firstIndex(where: { $0.id == gameID}) ?? 0
    }

    var body: some View {
        VStack (spacing: 5) {
            HStack {
                Button(action: {(self.startGame())}) {
                    Text("Start Game")
                }
                Spacer()
                Button(action: {self.start2ndHalf()}) {
                    Text("Start 2nd Half")
                }
            }
            
            Spacer()
            
            // Timer
            ShowTimer()
            
            Spacer()
            
            // Stats buttons
            ShowStatsButtons(gameIndex: self.gameIndex)
             
            Spacer()
            
            // Us or Them selector
            Picker("", selection: $appData.gameState.team) {
                Text("Us").tag(Team.us)
                Text("Them").tag(Team.them)
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())

            Spacer()
            
            // Summary View
            Button(action: {
                self.showLog.toggle()
            }) {
                Text("Show Game Log")
            } .sheet(isPresented: $showLog) {
                ShowLog(gameIndex: self.gameIndex).environmentObject(self.appData)
                // .environmentObject is needed becasue appData is not inhirited
            }
        }
        .padding()
        .navigationBarTitle(appData.games.count > 0 ? appData.games[self.gameIndex].opponent : "")
    }
    
    func startGame() {
        elapsedSeconds = 0
        appData.gameState.half = .first
        appData.games[self.gameIndex].log = []
        appData.games[self.gameIndex].stats.removeAll()
        for t in Team.allCases {
            for s in StatType.allCases {
                appData.games[self.gameIndex].stats.append(StatSummary(team: t, type: s, count: 0))
            }
        }
    }
    
    func start2ndHalf() {
        self.appData.gameState.half = .second
        elapsedSeconds = appData.games[self.gameIndex].halfLength * 60
    }
    
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11"], id:\.self) { deviceName in
            GameDetail(gameID: gameData[0].id)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}

struct ShowTimer: View {
    @EnvironmentObject var appData: AppModel
    @State var timerDisplay: String = "0:00"
    @State var elapsedSeconds: Int = 0

    var timer = Timer.publish (every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timerDisplay)
            .padding(15)
            .frame(width: 180, height: 70)
            .font(.system(size: 36, design: .monospaced))
            .background(Color.gray)
            .opacity(0.4)
            .cornerRadius(20)
            .onReceive(timer) { _ in
                self.updateTimer()
        }
    }

    func updateTimer() {
        self.elapsedSeconds += 1
        self.appData.gameState.gameClock = self.elapsedSeconds
        let m = self.elapsedSeconds % 3600 / 60
        let s = self.elapsedSeconds % 60
        self.timerDisplay = String(format: "%01d:%02d", m, s)
    }
}
