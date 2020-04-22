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
    
    @EnvironmentObject var e_: AppModel
    @State private var showLog = false

    // idx will be used to acccess or update the model
    var idx: Int {
        e_.games.firstIndex(where: { $0.id == gameID}) ?? 0
    }

    var body: some View {
        VStack (spacing: 5) {
            HStack { // Buttons: Start Game and Start 2nd Half
                if e_.games[idx].gameState == .notStarted {
                    Button(action: {self.startGame() }) {
                        Text("Start Game")
                    }
                } else { // disabled Start Game button
                    Text("Start Game").foregroundColor(.gray)
                }
                Spacer()
                if e_.games[idx].gameState == .firstHalf {
                    Button(action: {self.start2ndHalf() }) {
                        Text("Start 2nd Half")
                    }
                } else { // disabled Start Game button
                    Text("Start 2nd Half").foregroundColor(.gray)
                }
            }
            Spacer()
            
            // Timer
            if (e_.games[idx].gameState == .firstHalf || e_.games[idx].gameState == .secondHalf) {
                ShowTimer(idx: idx)
            } else {
                Text("").font(.system(size: 36, design: .monospaced))
                .frame(width: 150, height: 70)
            }
            Spacer()
            
            // Stats buttons
            ShowStatsButtons(idx: self.idx)
            
            if e_.games[idx].lastStatIndex[e_.games[idx].currentTeam]! > -1 {
                Button(action: { self.undoStat() }) {
                    Text("Undo Last Stat").frame(height: 60)
                }
            } else { // disabled undo button
                Text("Undo Last Stat").foregroundColor(.gray).frame(height: 60)
            }
            Spacer()
            
            // Us or Them selector
            Picker("", selection: $e_.games[idx].currentTeam) {
                Text("Us").tag(Team.us)
                Text("Them").tag(Team.them)
            }   .padding().pickerStyle(SegmentedPickerStyle())
            Spacer()
            
            // Summary View
            Button(action: {
                self.showLog.toggle()
            }) {
                Text("Show Game Log")
            } .sheet(isPresented: $showLog) {
                GameLog(idx: self.idx).environmentObject(self.e_)
                // .environmentObject is needed becasue e_ is not inhirited
            }
        }   .padding()
            .navigationBarTitle(e_.games.isEmpty ? "" : e_.games[idx].opponent)
            .onAppear(perform: resetGameState)
    }
    
    func resetGameState() {
        e_.games[idx].currentTeam = .us
        e_.games[idx].lastStatIndex = [Team.us: -1, Team.them: -1]
    }
    
    func startGame() {
        resetGameState()
        
        e_.games[idx].gameState = .firstHalf
        e_.games[idx].firstHalfStartDate = Date()
        e_.games[idx].log = []
        e_.games[idx].stats.removeAll()
        for t in Team.allCases {
            for s in StatType.allCases {
                e_.games[idx].stats.append(StatSummary(team: t, type: s, count: 0))
            }
        }
    }
    
    func start2ndHalf() {
        e_.games[idx].gameState = .secondHalf
        e_.games[idx].secondHalfStartDate = Date()
    }
    
    func undoStat() {
        e_.games[idx].stats[e_.games[idx].lastStatIndex[e_.games[idx].currentTeam]!].count -= 1
        e_.games[idx].log.removeLast(1)
        e_.games[idx].lastStatIndex[e_.games[idx].currentTeam] = -1
    }
}

struct ShowTimer: View {
    @State var idx: Int
    @EnvironmentObject var e_: AppModel
    @State var timerDisplay: String = ""
    @State var timer = Timer.publish (every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timerDisplay)
            .font(.system(size: 36, design: .monospaced))
            .frame(width: 150, height: 70)
            .background(Color.gray).opacity(0.4).cornerRadius(10)
            .onReceive(timer) { _ in
                self.updateTimer()
        }
    }

    func updateTimer() {
        let curretState = e_.games[idx].gameState
        if (curretState == .firstHalf || curretState == .secondHalf) {
            if curretState == .firstHalf {
                e_.games[idx].elapsedSeconds = Int(Date().timeIntervalSince(e_.games[idx].firstHalfStartDate))
            }
            if curretState == .secondHalf {
                e_.games[idx].elapsedSeconds = Int(Date().timeIntervalSince(e_.games[idx].secondHalfStartDate)) + e_.games[idx].halfLength * 60
            }

            let m = e_.games[idx].elapsedSeconds % 3600 / 60
            let s = e_.games[idx].elapsedSeconds % 60
            self.timerDisplay = String(format: "%01d:%02d", m, s)
        }
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
