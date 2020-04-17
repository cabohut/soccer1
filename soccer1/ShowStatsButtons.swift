//
//  ShowStatsButtons.swift
//  soccer1
//
//  Created by sam on 4/1/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct ShowStatsButtons: View {
    var gameIndex: Int
    @EnvironmentObject var appData: AppModel

    let labels = StatType.allCases
    // statLabels is 3x3 matrix for the stats buttons layout
    let statLabels = [
        [StatType.fk, StatType.ck, StatType.pk],
        [StatType.shot, StatType.save, StatType.goal],
        [StatType.offside, StatType.fifty, StatType.pass]
    ]

    var body: some View {
        VStack (spacing: 25){
            ForEach(statLabels, id: \.self) { row in
                HStack (spacing: 25){
                    ForEach(row, id: \.self) { statLabel in
                        Button(action: { (self.addStat(type: statLabel))
                            withAnimation {}
                        }) {
                            VStack {
                                // show stat count
                                Text(self.getStat(type: statLabel))
                                    .font(self.bW() > 50 ? .subheadline : .caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)

                                Text("")

                                // show stat label
                                Text(statLabel.rawValue)
                                    .font(self.bW() > 50 ? .subheadline : .caption)
                                    .fontWeight(self.bW() > 50 ? .bold : .none)
                            }
                            .frame(width: self.bW(), height: self.bW())
                            .padding(10)
                            .foregroundColor(.white)
                            .background(self.appData.gameState.team == .us ? _usButtonColor : _themButtonColor)
                            .cornerRadius(self.bW())
                        }
                    } // ForEach statLabel
                }
            } // ForEach row
        }
    }
    
    func getStat(type: StatType) -> String {
        // get index for the stat
        if appData.games.count > 0 {
            guard let statIndex = appData.games[self.gameIndex].stats.firstIndex(where: { $0.team.rawValue == self.appData.gameState.team.rawValue && $0.type == type}) else { return " " }
            let s = appData.games[self.gameIndex].stats[statIndex].count > 0 ? String(appData.games[self.gameIndex].stats[statIndex].count) : " "
            return (s)
        } else {
            return ("")
        }
    }
    
    func addStat(type: StatType) {
        // get the stat index
        guard let statIndex = appData.games[gameIndex].stats.firstIndex(where: { $0.team.rawValue == appData.gameState.team.rawValue && $0.type == type}) else { return }
        
        // Save last stat index for Undo
        self.appData.gameState.lastStatIndex[appData.gameState.team] = statIndex
        
        // increment the stat count by 1
        appData.games[gameIndex].stats[statIndex].count += 1
        
        // add stat log
        appData.games[gameIndex].log +=
                    [StatLog(time: appData.gameState.gameClock / 60 + 1,
                    stat: type,
                    team: appData.gameState.team)]
    }

    // calculate buttong width
    func bW() -> CGFloat {
        let w = (UIScreen.main.bounds.width - 3 * 65) / 3
        return w
    }
}

struct ShowStatsButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11"], id:\.self) { deviceName in
            ShowStatsButtons(gameIndex: 0)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
