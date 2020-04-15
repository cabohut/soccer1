//
//  GameRow.swift
//  soccer1
//
//  Created by sam on 3/27/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

struct GameRow: View {
    var game: Game

    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                HStack {
                    Text(game.opponent).fontWeight(.bold)
                        .frame(width: 100, alignment: .leading)
                    Text(game.location)
                        .frame(width: 100, alignment: .leading)
                }
                Text(game.gameDate).font(.subheadline).foregroundColor(.gray)
                    .frame(width: 100, alignment: .leading)
            }
            Spacer()
            Text(game.finalScore).frame(width: 40, alignment: .trailing)
        }
        .padding()
    }
}

struct GameRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameRow(game: gameData[0])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
