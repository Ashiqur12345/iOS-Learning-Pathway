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
            noOfPairsToShow: 3,
            color: Colors.Orange
        ),
        Theme(
            name: "Alive",
            emojies: ["🐧", "🐔", "🐤", "🐒", "🦉", "🐢", "🦞", "🪲", "🐝", "🦋", "🐛", "🐞", "🕷", "🐅", "🐫", "🦏", "🦒", "🐄", "🦌", "🐈", "🦩", "🦜"],
            noOfPairsToShow: 15,
            color: Colors.Brown
        ),
        Theme(
            name: "Fresh",
            emojies: ["🌵", "🎄", "🌲", "🌳", "🌴", "🌱", "🌿", "☘️", "🍀", "🍃", "🎋", "🪴", "🎍", "🍂", "🍁", "💐", "🌷", "🌹", "🌺", "🌸", "🌻", "🌼", "🥀", "🪷"],
            noOfPairsToShow: 15,
            color: Colors.Green
        ),
    ]
    private static var selectedTheme: Theme = themes[0]
    
    @Published private var model : CardGame<String>

    init() {
        model = CardGame<String>(noOfPairs: CardGameEmoji.selectedTheme.noOfPairsToShow)
            { pairIndex in
                CardGameEmoji.selectedTheme.emojies[pairIndex]
            }
    }
    
    var cards : Array<Card>{
        return model.cards
    }
    
    var isGameWon : Bool{
        return model.isGameWon()
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
        model = CardGame<String>(noOfPairs: myMin(CardGameEmoji.selectedTheme.noOfPairsToShow, b: CardGameEmoji.selectedTheme.emojies.count) )
            { pairIndex in
                CardGameEmoji.selectedTheme.emojies[pairIndex]
            }
    }
    
    
    
    struct Theme{
        let name : String
        let emojies: [String]
        var noOfPairsToShow : Int
        let color : Colors
    }
    
    func myMin (_ a: Int, b: Int) -> Int {
        if a > b {
            return b
        }
        return a
    }
}
