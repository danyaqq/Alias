//
//  AliasDataModel.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation

class AliasDataModel{
    
    //MARK: - Init properties
    var wordsForVictory: Int = 60
    var time: Int = 0
    var cateogory: Category? = nil
    var teams: [Team] = []
    var rounds: Int = 0
    var currentRound: Int = 1
    
    //MARK: - Game properties
    var selectedTeam: Team? = nil
    var currentWord: String? = nil

    func getRandomWord(){
        let randomWord = cateogory?.words.randomElement()
        currentWord = randomWord?.title
    }
    
    //game setup
    func gameSetup(){
        self.selectedTeam = teams.first
        self.rounds = teams.count
    }
    
    //add point for selected team
    func addPoint(){
        selectedTeam?.score += 1
        selectedTeam?.guessedWords += 1
        getRandomWord()
    }
    
    //remove point for selected team
    func removePoint(){
        selectedTeam?.score -= 1
        getRandomWord()
    }
    
    //change selected team after time == 0
    func changeSelectedTeam(){
        currentRound += 1
        selectedTeam = teams[currentRound - 1]
    }
    
    func resetGame(){
        for team in teams {
            team.score = 0
            team.guessedWords = 0
        }
        selectedTeam = teams[0]
        currentRound = 1
    }
    
}
