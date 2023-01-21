//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct CardGameEmojiView: View {

    @ObservedObject var viewModel: CardGameEmoji
    @State var dealt = Set<Int>()
    @Namespace private var myNameSpace
    
    private func isDealt(_ card: CardGameEmoji.Card) -> Bool{
        dealt.contains(card.id)
    }
    private func deal(_ card: CardGameEmoji.Card){
        dealt.insert(card.id)
    }
    private func calcDelay(of card: CardGameEmoji.Card) -> Double{
        let index = Double(viewModel.cards.firstIndex{$0.id == card.id} ?? 0) * 0.1
        return Double(index)
    }
    private func calcZIndex(of card: CardGameEmoji.Card) -> Double{
        -Double(viewModel.cards.firstIndex{$0.id == card.id} ?? 0)
    }
    
    private var cards: some View {
        return AspectVGrid(items: viewModel.cards, aspectRatio: 1){ card in
            if(card.isMatched && !card.isFaceUp || !isDealt(card)){
                Rectangle().opacity(0)
            }
            else{
                CardView(card: card)
                    .padding(5)
                    .matchedGeometryEffect(id: card.id, in: myNameSpace)
                    .zIndex(calcZIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut){
                            viewModel.choose(card)
                        }
                    }.transition(.asymmetric(insertion: .identity, removal: .scale.animation(.linear)))
            }
        }.onAppear{
            
        }
    }
    
    @ViewBuilder
    private var gameInfo: some View{
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
                withAnimation(.spring()){
                    viewModel.playAgain()
                    dealt = []
                }
            })
            {
                Image(systemName:"play")
                    .font(.title)
            }
        }.transition(.scale.animation(.easeInOut))
    }
    private var shuffle : some View{
        Button(action: {
            withAnimation(.easeInOut){
                viewModel.shuffle()
            }
        }){
            Text("Shuffle").font(.title)
        }
    }
    private var deck : some View{
        ZStack{
            ForEach(viewModel.cards){ card in
                if !isDealt(card){
                    CardView(card: card)
                        .padding(5)
                        .matchedGeometryEffect(id: card.id, in: myNameSpace).zIndex(calcZIndex(of: card))
                        .transition(.asymmetric(insertion: .scale.animation(.linear), removal: .identity))
                }
            }
        }
        .frame(width: 100, height: 100).transition(.scale.animation(.linear))
        .onTapGesture{
            for card in viewModel.cards{
                withAnimation(.easeInOut.delay(calcDelay(of: card))){
                    deal(card)
                }
            }
        }
    }
    var body: some View {
        
        ZStack(alignment: .center){
            
            if(viewModel.isGameWon){
                gameWon
            }
            else{
                ZStack(alignment: .bottom){
                    VStack{
                        gameInfo
                        cards
                        if dealt.count >= viewModel.cards.count{
                            shuffle
                        }
                    }
                    deck
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
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
//                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .font(sizedFont(min(geometry.size.height, geometry.size.width)))
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
