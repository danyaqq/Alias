//
//  Team.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation


class Team{
    var name: String
    var score: Int = 0
    var guessedWords: Int = 0
    init(name: String){
        self.name = name
    }
}
