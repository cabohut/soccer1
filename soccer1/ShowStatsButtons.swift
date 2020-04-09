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
                        Button(action: { (self.appData.games[self.gameIndex].stats[button]! += 1)
                            withAnimation {}
                        }) {
                            VStack {
                                Text(self.appData.games[self.gameIndex].stats[button]?.description ?? "")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.yellow)
                                Text("")
                                Text(button.rawValue)
                                    .fontWeight(.bold)
                            }
                            .frame(width: self.bW(), height: self.bW())
                            .padding(10)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(self.bW())
                        }
                    } // ForEach row
                }
            } // ForEach buttons
        }
    }

    // calculate buttong width
    func bW() -> CGFloat {
        return (UIScreen.main.bounds.width - 3 * 65) / 3
    }
}

struct ShowStatsButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 11"], id:\.self) { deviceName in
            ShowStatsButtons(gameIndex: 0)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
