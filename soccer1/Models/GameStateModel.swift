//
//  GameStateModel.swift
//  soccer1
//
//  Created by sam on 4/3/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import Foundation

// I think this needs to be 'struct' for Binding to work
struct GameState {
    var s: StatType = .fk
    var half: Half = .first
    var elapsedSeconds: Int = 0
    var team: Team = .us
    var lastStatIndex: [Team: Int] = [Team.us: -1, Team.them: -1]
}

enum Half: Int, Codable {
    case first = 1
    case second = 2
}
