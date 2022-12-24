//
//  CardGame.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


struct CardGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards : Array<CardGame.Card>
    private var theOneAndOnlyFaceupCardIndex: Int?{
        get{ cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly }
        set{
            cards.indices.forEach({cards[$0].isFaceUp = $0 == newValue})
        }
    }
    
    init(noOfPairs: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        
        for pairIndex in 0..<noOfPairs
        {
            cards.append(Card(content: cardContentMaker(pairIndex), id: pairIndex*2))
            cards.append(Card(content: cardContentMaker(pairIndex), id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) -> Void {
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let otherIndex = theOneAndOnlyFaceupCardIndex{
                if(cards[chosenIndex].content == cards[otherIndex].content){
                    cards[chosenIndex].isMatched = true
                    cards[otherIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
            }
            else{
                theOneAndOnlyFaceupCardIndex = chosenIndex
            }
            
        }
    }
    
    func isGameWon() -> Bool {
        for i in cards.indices{
            if !cards[i].isMatched {
                return false
            }
        }
        return true
    }
    
    struct Card: Identifiable{
        var isMatched = false
        var isFaceUp = false
        var content: CardContent
        var id: Int
    }
}

extension Array{
    var oneAndOnly : Element?{
        if self.count == 1 {
            return self.first
        }
        else {
            return nil
        }
    }
}
