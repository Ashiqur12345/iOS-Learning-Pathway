//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct CardGameEmojiView: View {

    @ObservedObject var viewModel: CardGameEmoji
    
    private var cards: some View {
        return AspectVGrid(items: viewModel.cards, aspectRatio: 1){ card in
            if(card.isMatched && !card.isFaceUp){
                Rectangle().opacity(0)
            }
            else{
                CardView(card: card)
                    .padding(5)
                    .onTapGesture {
                        withAnimation{
                            viewModel.choose(card)
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private func gameInfo()-> some View{
        HStack{
            Text("Set of ").font(.title)
            Text("\(viewModel.cardsInSet)").font(.title).bold()
            Text(" cards").font(.title)
        }
        HStack{
            Text("Max Achievable Score ").font(.title)
            Text("\(viewModel.maxAchievableScore)").font(.title).bold()
        }
        HStack{
            Text("Your Score ").font(.title)
            Text("\(viewModel.score)").font(.title).bold()
        }
    }
    
    private var gameWon: some View{
        return VStack{
            HStack{
                Text("Your Score ").font(.title)
                Text("\(viewModel.score)").font(.title).bold()
            }.padding(.vertical)
            
            Button(action: {
                viewModel.playAgain()
            })
            {
                Image(systemName:"play")
                    .font(.title)
                    .imageScale(.large)
            }
        }
    }
    
    var body: some View {
        
        ZStack(alignment: .center){
            
            if(viewModel.isGameWon){
                gameWon
            }
            else{
                VStack{
                    gameInfo()
                    cards
                    Button(action: {
                        withAnimation{
                            viewModel.shuffle()
                        }
                    }){
                        Text("Shuffle").font(.title)
                    }
                }
            }
        }
        .padding(.horizontal).foregroundColor(viewModel.color)
    }
}

struct CardView: View{

    let card: CardGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                ZStack{
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 320-90)).fill(.yellow).opacity(0.5)
                    Text(card.content).font(sizedFont(min(geometry.size.height, geometry.size.width)))
                }.cardify(isFaceUp: card.isFaceUp)
                
                if(!card.isAlreadySeen && !card.isFaceUp){
                    Text(DrawingConstants.unseenCardIndicator).font(.title)
                }
            }
        }
    }
    
    private func sizedFont(_ size: CGFloat) -> Font{
        Font.system(size: size * DrawingConstants.fontSizeScalar)
    }
    
    struct DrawingConstants{
        static let fontSizeScalar       : CGFloat = 0.7
        static let unseenCardIndicator  : String = "🎁"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CardGameEmoji = CardGameEmoji()
        viewModel.choose(viewModel.cards.first!)
        return CardGameEmojiView(viewModel: viewModel).preferredColorScheme(.light)
//        CardGameEmojiView(viewModel: viewModel).previewInterfaceOrientation(.landscapeLeft)
    }
}
