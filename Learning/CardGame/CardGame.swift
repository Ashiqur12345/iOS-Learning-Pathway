//
//  CardGame.swift
//  Learning
//
//  Created by itiw-mac 256 on 11/24/22.
//

import Foundation


struct CardGame<CardContent> where CardContent: Equatable{
    
    private(set) var cards : Array<CardGame.Card>
    private(set) var noOfCardsInSet : Int = 2
    private(set) var score : Int
    private(set) var maxAchievableScore : Int
    
    private var faceupCardContent: CardContent?{
        get{ cards.first(where: {$0.isFaceUp && !$0.isMatched})?.content }
    }
    private var unmatchedFaceupCardIndices: [Int]{
        get{ cards.indices.filter({cards[$0].isFaceUp}) }
    }
    
    init(noOfSets: Int, noOfCardsInSet: Int, cardContentMaker : (Int)->CardContent) {
        
        cards = Array<Card>()
        score = 0
        maxAchievableScore = noOfSets * noOfCardsInSet
        self.noOfCardsInSet = noOfCardsInSet
        for setIndex in 0..<noOfSets
        {
            for i in 0..<noOfCardsInSet
            {
                cards.append(Card(content: cardContentMaker(setIndex), id: setIndex*noOfCardsInSet + i))
            }
        }
        shuffle()
    }
    
    mutating func shuffle() -> Void {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) -> Void {
        
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            
            
            if let content = faceupCardContent {
                if cards[chosenIndex].content == content {
                    if unmatchedFaceupCardIndices.count == noOfCardsInSet - 1{
                        for faceupIndex in unmatchedFaceupCardIndices{
                            cards[faceupIndex].isMatched = true
                        }
                        cards[chosenIndex].isMatched = true
                        score += noOfCardsInSet
                    }
                }
                else{
                    for faceupIndex in unmatchedFaceupCardIndices
                    {
                        cards[faceupIndex].isFaceUp = false
                        if cards[faceupIndex].isAlreadySeen{
                            score -= 1
                        }
                        else{
                            cards[faceupIndex].isAlreadySeen = true
                        }
                    }
                }
            }
            else{
                for index in unmatchedFaceupCardIndices
                {
                    cards[index].isFaceUp = false
                }
            }
            cards[chosenIndex].isFaceUp = true
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
        var isMatched = false{
            didSet{
                stopUsingBonusTime()
            }
        }
        var isFaceUp = false{
            didSet{
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isAlreadySeen = false
        let content: CardContent
        let id: Int
        
        
        
        
        
        
        
        
        
        // MARK: - Bonus Time
        
        // this could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        // the last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        // the accumulated time this card has been face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        // whether we are currently face up, unmatched and have not yet used up the bonus window
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
