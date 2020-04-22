//
//  GameLog.swift
//  soccer1
//
//  Created by sam on 4/7/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameLog: View {
    var idx: Int

    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @EnvironmentObject var e_: AppModel

    var body: some View {
        VStack {
            List {
                Section(header: Text("Game Log")) {
                    ForEach(0..<self.e_.games[self.idx].log.count, id: \.self) { i in
                        HStack {
                            Text(String(self.e_.games[self.idx].log[i].time) + "'")
                                .frame(width: 30, alignment: .trailing)
                            Spacer(minLength: 30)
                            Text(self.e_.games[self.idx].log[i].stat.rawValue)
                                .frame(width: 70, alignment: .center)
                            Spacer(minLength: 30)
                            Text(self.e_.games[self.idx].log[i].team.rawValue)
                                .frame(width: 60, alignment: .center)
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 40)
                            .font(.headline)
                            .foregroundColor(self.e_.games[self.idx].log[i].team == .us ? _usButtonColor : _themButtonColor)
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

struct GameLog_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone 11"], id:\.self) { deviceName in
            GameLog(idx: 0)
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
            .environmentObject(AppModel())
        }
    }
}
