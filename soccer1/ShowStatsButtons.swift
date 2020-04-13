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
    let buttons = [
        [StatType.fk, StatType.ck, StatType.pk],
        [StatType.shot, StatType.save, StatType.goal],
        [StatType.offside, StatType.fifty, StatType.pass]
    ]

    var body: some View {
        VStack (spacing: 25){
            ForEach(buttons, id: \.self) { row in
                HStack (spacing: 25){
                    ForEach(row, id: \.self) { button in
                        Button(action: { (self.addStat(statType: button))
                            withAnimation {}
                        }) {
                            VStack {
                                // show stat count
                                Text(self.appData.games[self.gameIndex].stats[self.appData.gameState.team]?[button]?.description ?? "")
                                    .font(self.bW() > 50 ? .subheadline : .caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)

                                Text("")
                                
                                // show stat label
                                Text(button.rawValue)
                                    .font(self.bW() > 50 ? .subheadline : .caption)
                                    .fontWeight(self.bW() > 50 ? .bold : .none)
                            }
                            .frame(width: self.bW(), height: self.bW())
                            .padding(10)
                            .foregroundColor(.white)
                            .background(self.appData.gameState.team == .us ? _usButtonColor : _themButtonColor)
                            .cornerRadius(self.bW())
                        }
                    } // ForEach row
                }
            } // ForEach buttons
        }
    }

    func addStat(statType: StatType) {
        self.appData.games[self.gameIndex].stats[self.appData.gameState.team]![statType]! += 1
        self.appData.games[self.gameIndex].log +=
                    [StatLog(time: self.appData.gameState.gameClock / 60,
                    stat: statType,
                    team: self.appData.gameState.team)]
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
