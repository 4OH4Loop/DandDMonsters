//
//  MonstersViewModel.swift
//  DandDMonsters
//
//  Created by Carolyn Ballinger on 4/14/25.
//

import Foundation
import SwiftData

@Observable
class MonstersViewModel {
    struct Results: Codable {
        var count: Int
        var results: [Monster]
    }
    
    var count: Int = 0
    var monsters: [Monster] = []
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
            guard let returned = try? JSONDecoder().decode(Results.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned data at \(urlString)")
                isLoading = false
                return
            }
            print("😎 JSON RETURNED: We have just returned \(returned.results.count) monsters")
            
            Task {@MainActor in
                self.count = returned.count
                self.monsters = returned.results
                isLoading = false

            }
        } catch {
            isLoading = false
            print("😡 ERROR: Could not get data from \(urlString) \(error.localizedDescription)")
        }
    }
    
}
