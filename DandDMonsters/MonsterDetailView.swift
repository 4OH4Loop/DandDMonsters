//
//  MonsterDetailView.swift
//  DandDMonsters
//
//  Created by Carolyn Ballinger on 4/25/25.
//

import SwiftUI

struct MonsterDetailView: View {
    @State var monster: Monster
    @State private var monsterDetailVM = MonsterDetailViewModel()
    var body: some View {
        VStack {
            Text(monster.name)
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Type:")
                        .bold()
                    Text(monsterDetailVM.type.capitalized)
                        .padding(.bottom)
                    
                    Text("Alignment:")
                        .bold()
                    Text(monsterDetailVM.alignment.capitalized)
                        .padding(.bottom)
                }
                Spacer()
                
                VStack (alignment: .leading) {
                    Text("Size:")
                        .bold()
                    Text(monsterDetailVM.size.capitalized)
                        .padding(.bottom)
                    
                    Text("Hit Points:")
                        .bold()
                    Text("\(monsterDetailVM.hitPoints)")
                        .padding(.bottom)
                }
            }
            .font(.title)
            
            AsyncImage(url: URL(string: monsterDetailVM.imageURL)) { phase in
            if let image = phase.image {
                    image
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 16)
                }
                else if phase.error != nil {
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 16)
                } else {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .task {
            monsterDetailVM.urlString = monsterDetailVM.baseURL + monster.url
            await monsterDetailVM.getData()
        }
        
    }
}

#Preview {
    MonsterDetailView(monster: Monster(
        index: "adult-gold-dragon",
        name: "Adault Gold Dragon",
        url: "/api/2014/monsters/adult-gold-dragon"
    )
    )
}
