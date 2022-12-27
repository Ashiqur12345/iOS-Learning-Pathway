//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct CardGameEmojiView: View {

    @ObservedObject var viewModel: CardGameEmoji
    
    var body: some View {
        
        ZStack(alignment: .center){
            
            if(viewModel.isGameWon){
                VStack{
                    HStack{
                        Text("Your Score ").font(.title)
                        Text("\(viewModel.score)").font(.title).bold()
                    }
                    Divider()
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
            else{
                VStack{
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
                    AspectVGrid(items: viewModel.cards, aspectRatio: 1){ card in
                        if(card.isMatched && !card.isFaceUp){
                            Rectangle().opacity(0)
                        }
                        else{
                            CardView(card: card)
                                .padding(5)
                                .onTapGesture {
                                viewModel.choose(card)
                            }
                        }
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                
                if(card.isFaceUp){
                    shape
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 320-90)).fill(.yellow).opacity(0.5)
                    shape.strokeBorder(lineWidth:DrawingConstants.lineWidth).foregroundColor(.brown)
                    Text(card.content).font(sizedFont(min(geometry.size.height, geometry.size.width)))
                }
                else{
                    shape.fill(.gray)
                    if(!card.isAlreadySeen && !card.isFaceUp){
                        Text("🎁").font(.title)
                    }
                }
            }
        }
    }
    
    private func sizedFont(_ size: CGFloat) -> Font{
        Font.system(size: size * DrawingConstants.fontSizeScalar)
    }
    
    struct DrawingConstants{
        static let cornerRadius     : CGFloat = 10
        static let lineWidth        : CGFloat = 3
        static let fontSizeScalar   : CGFloat = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CardGameEmoji = CardGameEmoji()
//        viewModel.choose(viewModel.cards.first!)
        return CardGameEmojiView(viewModel: viewModel).preferredColorScheme(.light)
//        CardGameEmojiView(viewModel: viewModel).previewInterfaceOrientation(.landscapeLeft)
    }
}
