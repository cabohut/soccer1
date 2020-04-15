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

//let gameData: [Game] = load("gameData.json")
//let gameData = [Game]()
let gameData: [Game] = sampleData()

final class AppModel: ObservableObject {
    @Published var gameState = GameState()
    @Published var games: [Game] = gameData
}

func sampleData () -> [Game] {
    var sampleGames = [Game]()
    let numSamples = 2
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
        sampleGames[i].finalScore = "3-1"
        sampleGames[i].log = []
        for t in Team.allCases {
            for s in StatType.allCases {
                let n = Int.random(in: 0..<15)
                sampleGames[i].stats.append(StatSummary(team: t, type: s, count: n))
            }
        }
        
        print(sampleGames.count)
        for j in 0..<numSampleStats {
            let t = Team.allCases.randomElement()!
            let s = StatType.allCases.randomElement()!
            print(i)
            sampleGames[i].log.append(StatLog(time: j*3, stat: s, team: t))
        }
    }
    
    return sampleGames
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func printJSON () {
    // use this method to print out the JSON format for the Swift object
    //let games = [Game(id: 1, gameDate: "3/1/20", halfLength: 40, opponent: "Poway", location: "Community", finalScore: "3-0", log: [StatLog(time: 1, stat: .fk, team: .us)], stats: [.fk:0, .shot:1]), Game(id: 2, gameDate: "3/8/20", halfLength: 40, opponent: "La Jolla", location: "Community", finalScore: "2-1", log: [StatLog(time: 3, stat: .ck, team: .us)], stats: [.ck:1, .pass:4])]
    
//    do {
//        let jsonData = try JSONEncoder().encode(games)
//        let jsonString = String(data: jsonData, encoding: .utf8)!
//        print(jsonString)
//
//        // and decode it back
//        let decodedSentences = try JSONDecoder().decode([Game].self, from: jsonData)
//        print(decodedSentences)
//    } catch { print(error) }
}
