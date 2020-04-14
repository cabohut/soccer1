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
            Text(game.gameDate)
                .frame(width: 100, alignment: .leading)
            Text(game.opponent)
                .frame(width: 100, alignment: .leading)
            Text(game.finalScore)
            Spacer()
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
