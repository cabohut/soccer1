//
//  ShowLog.swift
//  soccer1
//
//  Created by sam on 4/7/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct ShowLog: View {
    var gameIndex: Int

    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @EnvironmentObject var appData: AppModel

    var body: some View {
        VStack {
            List {
                Section(header: Text("Game Log")) {
                    ForEach(0..<self.appData.games[self.gameIndex].log.count, id: \.self) { i in
                        HStack {
                            Text(String(self.appData.games[self.gameIndex].log[i].time) + "'")
                                .frame(width: 30, alignment: .trailing)
                            Spacer(minLength: 30)
                            Text(self.appData.games[self.gameIndex].log[i].stat.rawValue)
                                .frame(width: 70, alignment: .center)
                            Spacer(minLength: 30)
                            Text(self.appData.games[self.gameIndex].log[i].team.rawValue)
                                .frame(width: 60, alignment: .center)
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .font(.headline)
                            .foregroundColor(self.appData.games[self.gameIndex].log[i].team == .us ? _usButtonColor : _themButtonColor)
                    }
                }
            }

            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
            }
        }
    }
}

struct ShowLog_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11"], id:\.self) { deviceName in
            ShowLog(gameIndex: 0)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
