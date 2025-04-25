//
//  MonsterDetailViewModel.swift
//  DandDMonsters
//
//  Created by Carolyn Ballinger on 4/25/25.
//

import Foundation

@Observable
class MonsterDetailViewModel {
    var name: String = ""
    var size: String = ""
    var type: String = ""
    var alignment: String = ""
    var hitPoints: Int = 0
    var imageURL: String = ""
    var baseURL = "https://www.dnd5eapi.co"
    var urlString = "https://www.dnd5eapi.co/api/2014/monsters"
    var isLoading = false
    
    func getData() async {
        isLoading = true
        print("We are accessing the url \(urlString)")
        guard let url = URL(string: urlString) else {
            print("😡 URL ERROR: Could not create URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let configuration = URLSessionConfiguration.ephemeral
            let session = URLSession(configuration: configuration)
            let (data, _) = try await session.data(from: url)
            guard let monsterDetail = try? JSONDecoder().decode(MonsterDetail.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned data at \(urlString)")
                isLoading = false
                return
            }
            print("😎 JSON RETURNED: We have just returned \(monsterDetail.name) from MonsterDetail")
            
            Task {@MainActor in
                self.name = monsterDetail.name
                self.size = monsterDetail.size
                self.type = monsterDetail.type
                self.alignment = monsterDetail.alignment
                self.hitPoints = monsterDetail.hit_points
                self.imageURL = baseURL + (monsterDetail.image ?? "")
                isLoading = false

            }
        } catch {
            isLoading = false
            print("😡 ERROR: Could not get data from \(urlString) \(error.localizedDescription)")
        }
    }
    
}
