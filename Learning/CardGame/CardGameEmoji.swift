//
//  CardGameEmoji.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


class CardGameEmoji: ObservableObject {
    
    static var emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"]
    
    private(set) static var noOfPairs = 5
    static func createEmojiCardGame() -> CardGame<String>{
        CardGame<String>(noOfPairs: noOfPairs){pairIndex in CardGameEmoji.emojis[pairIndex]}
    }
    
    @Published private var model : CardGame<String> = createEmojiCardGame()
    
    var cards : Array<CardGame<String>.Card>{
        return model.cards
    }
    
    var isGameWon : Bool{
        return model.isGameWon()
    }
    
    // MARK: Intents
    func choose(_ card: CardGame<String>.Card) -> Void {
        model.choose(card)
    }
    func playAgain() {
        CardGameEmoji.noOfPairs = Int.random(in: CardGameEmoji.emojis.indices)
        model = CardGameEmoji.createEmojiCardGame()
    }
}
