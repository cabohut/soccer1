//
//  ShowStatsButtons.swift
//  soccer1
//
//  Created by sam on 4/1/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct ShowStatsButtons: View {
    var idx: Int
    @EnvironmentObject var e_: AppModel

    let labels = StatType.allCases
    // statLabels is 3x3 matrix for the stats buttons layout
    let statLabels = [
        [StatType.pk, StatType.fk, StatType.ck],
        [StatType.shot, StatType.save, StatType.goal],
        [StatType.offside, StatType.fifty, StatType.pass]
    ]

    var body: some View {
        VStack (spacing: 25){
            ForEach(statLabels, id: \.self) { row in
                HStack (spacing: 25){
                    ForEach(row, id: \.self) { statLabel in
                        Button(action: { (self.addStat(type: statLabel))
                            //withAnimation {}
                        }) {
                            VStack (spacing: 10){
                                // show stat count
                                Text(self.getStat(type: statLabel))
                                    .font(self.bW() > 50 ? .headline : .subheadline)
                                    .foregroundColor(.yellow)

                                // show stat label
                                Text(statLabel.rawValue)
                                    .font(self.bW() > 50 ? .headline : .caption)
                            }
                            .frame(width: self.bW(), height: self.bW())
                            .padding(10)
                            .foregroundColor(.white)
                            .background(self.e_.games[self.idx].currentTeam == .us ? _usButtonColor : _themButtonColor)
                            .cornerRadius(self.bW())
                        }
                    } // ForEach statLabel
                }
            } // ForEach row
        }
    }
    
    func getStat(type: StatType) -> String {
        // get index for the stat
        if e_.games.count > 0 {
            guard let statIndex = e_.games[idx].stats.firstIndex(where: { $0.team.rawValue == e_.games[idx].currentTeam.rawValue && $0.type == type}) else { return " " }
            let s = e_.games[idx].stats[statIndex].count > 0 ? String(e_.games[idx].stats[statIndex].count) : " "
            return (s)
        } else {
            return ("")
        }
    }
    
    func addStat(type: StatType) {
        // get the stat index
        guard let statIndex = e_.games[idx].stats.firstIndex(where: { $0.team.rawValue == e_.games[idx].currentTeam.rawValue && $0.type == type}) else { return }
        
        // Save last stat index for Undo
        e_.games[idx].lastStatIndex[e_.games[idx].currentTeam] = statIndex
        
        // increment the stat count by 1
        e_.games[idx].stats[statIndex].count += 1
        
        // add stat log
        e_.games[idx].log +=
                    [StatLog(time: e_.games[idx].elapsedSeconds / 60 + 1,
                    stat: type,
                    team: e_.games[idx].currentTeam)]
    }

    // calculate buttong width
    func bW() -> CGFloat {
        let w = (UIScreen.main.bounds.width - 3 * 65) / 3
        return w
    }
}

struct ShowStatsButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone Xs"], id:\.self) { deviceName in
            ShowStatsButtons(idx: 0)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
