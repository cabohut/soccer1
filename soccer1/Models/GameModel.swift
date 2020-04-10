//
//  GameModel.swift
//  soccer1
//
//  Created by sam on 3/25/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import SwiftUI

// I think this needs to be 'struct' for Binding to work
struct Game: Hashable, Codable, Identifiable {
    var id: Int = 0
    var gameDate: String = ""
    var halfLength: Int = 35
    var opponent: String = ""
    var location: String = ""
    var finalScore: String = ""
    var log = [StatLog]()
    var stats = [Team: [StatType : Int]]()
}

struct StatLog: Hashable, Codable {
    var time: Int
    var stat: StatType
    var team: Team
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

func getDateTime() -> String {
    let currentDateTime = Date()
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .long
    let dateTimeString = formatter.string(from: currentDateTime)
    
    return dateTimeString
}
