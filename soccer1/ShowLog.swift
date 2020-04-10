//
//  ShowLog.swift
//  soccer1
//
//  Created by sam on 4/7/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct ShowLog: View {
    
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    
    @EnvironmentObject var appData: AppModel
    
    var body: some View {
        VStack {
            Text("Number of games = \(appData.games.count)")
            Divider()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Dismiss this view")
            }
        }
    }
}

struct ShowLog_Previews: PreviewProvider {
    static var previews: some View {
        ShowLog()
    }
}
