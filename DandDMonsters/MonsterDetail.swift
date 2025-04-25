//
//  MonsterDetail.swift
//  DandDMonsters
//
//  Created by Carolyn Ballinger on 4/25/25.
//

import Foundation

struct MonsterDetail: Codable {
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hit_points: Int = 0
    var image: String? = ""
}
