//
//  leagueView.swift
//  TennisTracker
//
//  Created by Arman Zadeh-Attar on 2022-05-11.
//

import SwiftUI

struct leagueView: View {
    //let leagueNames = ["Arman & Peter", "Andrew & Arman", "Andrew & Peter"]
    @ObservedObject var leagueVm = LeagueViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false){
                VStack{
                    ForEach(leagueVm.leagues, id: \.id){ index in
                        NavigationLink {
                            leagueDetailView(leagueVM: leagueVm) .navigationTitle(index.name).onAppear{leagueVm.getCurrentLeague(leagueId: index.id)}
                        } label: {
                            VStack{
                                Image("league")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.size.width - 50, height: UIScreen.main.bounds.size.height / 4)
                                    .padding(.horizontal)
                                HStack {
                                    Text(index.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.gray)
                                    Text("\(index.players.count)")
                                        .foregroundColor(.black)
                                    Rectangle().frame(width: 1, height: 20)
                                    let pos = getPos(players: index.players)
                                    Text("Position: \(pos)")
                                        .foregroundColor(.black)
                                }
                                .padding()
                                Divider().padding(.horizontal)
                            }
                            .padding()
                            .shadow(radius: 20)
                        }

                    }
                }
            }.navigationTitle("Leagues")
        }
    }
}

struct leagueView_Previews: PreviewProvider {
    static var previews: some View {
        leagueView()
    }
}

extension leagueView {
    func getPos(players: [Player]) -> Int {
        var pos: Int = 0
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return 0}
        for player in players {
            pos += 1
            if player.uid == uid {
                break
            }
        }
       return pos
    }
}
