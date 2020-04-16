//
// AppModel.swift
//  soccer1
//
//  Created by sam on 4/3/20.
//  Copyright © 2020 Cabohut. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

let _usButtonColor = Color.blue
let _themButtonColor = Color.gray

let gameData: [Game] = sampleData()

final class AppModel: ObservableObject {
    @Published var gameState = GameState()
    @Published var games: [Game] = gameData
}

func sampleData () -> [Game] {
    var sampleGames = [Game]()
    let numSamples = 30
    let numSampleStats = 15
    let opp = ["Poway", "4S", "La Jolla", "Encinitas", "Vista", "Hemet", "Galaxy"]
    let loc = ["Stonebridge", "Jerabek Park", "Community Park", "Spring Canyon", "Jerabek School"]

    for i in 0..<numSamples {
        sampleGames += [Game()]
        sampleGames[i].id = UUID()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        sampleGames[i].gameDate = dateFormatter.string(from: Date())
        sampleGames[i].opponent = opp.randomElement()!
        sampleGames[i].location = loc.randomElement()!
        let s = "\(String(Int.random(in: 0...5)))-\(String(Int.random(in: 0...5)))"
        sampleGames[i].finalScore = s
        sampleGames[i].log = []
        for t in Team.allCases {
            for s in StatType.allCases {
                let n = Int.random(in: 0..<15)
                sampleGames[i].stats.append(StatSummary(team: t, type: s, count: n))
            }
        }
        
        for j in 0..<numSampleStats {
            let t = Team.allCases.randomElement()!
            let s = StatType.allCases.randomElement()!
            sampleGames[i].log.append(StatLog(time: j*3, stat: s, team: t))
        }
    }
    
    return sampleGames
}
