//
//  TeamDataModel.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation


class TeamDataModel{
    var sampleTeams: [String] = ["Жаворонки", "Коты", "Мыши", "Жирафы", "Тигры", "Собаки", "Волки", "Совы"]
    var teams: [Team] = []
    
    //add team
    func addRandomTeamName(){
        var teamArray: [String] = []
        for team in sampleTeams {
            if !teams.contains(where: {$0.name == team}){
                guard let randomTeam = sampleTeams.shuffled().first(where: { item in
                    item == team
                }) else {
                    return
                }
                teamArray.append(randomTeam)
            }
        }
        guard let randomTeam = teamArray.shuffled().randomElement() else { return }
        teams.insert(Team(name: randomTeam), at: teams.count)
    }
    
    //(init teams array) add two random team
    func addItemsToSelectedTeams(){
        for _ in 0..<2{
            addRandomTeamName()
        }
    }
    
    //remove team
    func removeTeam(index: Int){
        teams.remove(at: index)
    }
    
}
