//
//  GameModel.swift
//  soccer1
//
//  Created by sam on 3/25/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

// I think this needs to be 'struct' for Binding to work
struct Game: Equatable, Hashable, Codable, Identifiable {
    var id = UUID()
    var gameState = GameState.notStarted
    var elapsedSeconds: Int = 0
    var firstHalfStartDate = Date()
    var secondHalfStartDate = Date()
    var currentTeam: Team = .us
    var currentStat: StatType = .fk
    var lastStatIndex: [Team: Int] = [Team.us: -1, Team.them: -1]
    var gameDate: String = ""
    var halfLength: Int = 35
    var opponent: String = ""
    var location: String = ""
    var finalScore: String = ""
    var log = [StatLog]()
    var stats = [StatSummary]()
}

struct StatLog: Hashable, Codable {
    var time: Int
    var stat: StatType
    var team: Team
}

struct StatSummary: Hashable, Codable {
    var team: Team
    var type: StatType
    var count: Int
}

enum StatType: String, Hashable, CaseIterable, Codable {
    // https://learnappmaking.com/enums-swift/
    case fk = "FK"
    case ck = "CK"
    case pk = "PK"
    case shot = "Shot"
    case save = "Save"
    case goal = "Goal"
    case offside = "Offside"
    case fifty = "50/50"
    case pass = "Pass"
}

enum Team: String, Hashable, CaseIterable, Codable {
    case us = "Us"
    case them = "Them"
}

enum GameState: Int, Codable {
    case notStarted = 0
    case firstHalf = 1
    case secondHalf = 2
    case ended = 3
}

