//
//  CardGameEmoji.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation
import SwiftUI

class CardGameEmoji: ObservableObject {
    
    enum Colors{case Orange; case Brown; case Green}
    typealias Card = CardGame<String>.Card
    
    
    static let themes = [
        Theme(
            name: "Sporty",
            emojies: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"],
            color: Colors.Orange
        ),
        Theme(
            name: "Alive",
            emojies: ["🐧", "🐔", "🐤", "🐒", "🦉", "🐢", "🦞", "🪲", "🐝", "🦋", "🐛", "🐞", "🕷", "🐅", "🐫", "🦏", "🦒", "🐄", "🦌", "🐈", "🦩", "🦜"],
            color: Colors.Brown
        ),
        Theme(
            name: "Fresh",
            emojies: ["🌵", "🎄", "🌲", "🌳", "🌴", "🌱", "🌿", "☘️", "🍀", "🍃", "🎋", "🪴", "🎍", "🍂", "🍁", "💐", "🌷", "🌹", "🌺", "🌸", "🌻", "🌼", "🥀", "🪷"],
            color: Colors.Green
        ),
    ]
    private static var selectedTheme: Theme = themes[0]
    private static var setStartIndex = 0
    private var noOfSets = 2
    private var noOfCardsInSet = 3
    
    @Published private var model : CardGame<String>

    init() {
        CardGameEmoji.setStartIndex = Int.random(in: 0..<CardGameEmoji.selectedTheme.emojies.count - noOfSets)
        model = CardGame<String>(noOfSets: noOfSets, noOfCardsInSet: noOfCardsInSet) {
            CardGameEmoji.selectedTheme.emojies[CardGameEmoji.setStartIndex + $0]
        }
    }
    
    var cards : Array<Card>{
        return model.cards
    }
    
    var isGameWon : Bool{
        return model.isGameWon()
    }
    
    var cardsInSet : Int{
        return noOfCardsInSet
    }
    
    var score : Int{
        return model.score
    }
    
    var maxAchievableScore : Int{
        return model.maxAchievableScore
    }
    
    var name : String{
        return CardGameEmoji.selectedTheme.name
    }
    
    var color : Color{
        switch CardGameEmoji.selectedTheme.color
        {
            case Colors.Orange: return .orange
            case Colors.Green: return .green
            case Colors.Brown: return .brown
        }
    }
    
    // MARK: Intents
    func choose(_ card: Card) -> Void {
        model.choose(card)
    }
    
    func playAgain() {
        CardGameEmoji.selectedTheme = CardGameEmoji.themes[Int.random(in: CardGameEmoji.themes.indices)]
        
        noOfSets = myMin(noOfSets+1, CardGameEmoji.selectedTheme.emojies.count)
        noOfCardsInSet = Int.random(in: 2...4)
        
        CardGameEmoji.setStartIndex = Int.random(in: 0..<CardGameEmoji.selectedTheme.emojies.count - noOfSets)
        model = CardGame<String>(noOfSets: noOfSets, noOfCardsInSet: noOfCardsInSet) {
            CardGameEmoji.selectedTheme.emojies[CardGameEmoji.setStartIndex + $0]
        }
    }
    
    struct Theme{
        let name : String
        let emojies: [String]
        let color : Colors
    }
}

func myMin (_ a: Int, _ b: Int) -> Int {
    return a > b ? b : a
}
