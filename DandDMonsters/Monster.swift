//
//  Monsters.swift
//  DandDMonsters
//
//  Created by Carolyn Ballinger on 4/14/25.
//

import Foundation
import SwiftData

struct Monster: Codable, Identifiable {
    let id = UUID().uuidString
    var index: String
    var name: String
    var url: String
    
    enum CodingKeys: CodingKey {
        case index
        case name
        case url
    }
}

@Observable
class Monsters {
    private struct Returned: Codable {
        var count: Int
        var next: String?
        var results: [Monster]
    }
    var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
    var count = 0
    var monstersArray: [Monster] = []
    var isLoading = false
}
