//
//  CardGameEmoji.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


class CardGameEmoji: ObservableObject {
    
    static var emojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱"]
    
    static func createEmojiCardGame() -> CardGame<String>{
        CardGame<String>(noOfCards: 10){pairIndex in CardGameEmoji.emojis[pairIndex]}
    }
    
    @Published var model : CardGame<String> = createEmojiCardGame()
    
    func choose(_ card: CardGame<String>.Card) -> Void {
        model.choose(card)
    }
    
    var cards : Array<CardGame<String>.Card>{
        return model.cards
    }
    
}
