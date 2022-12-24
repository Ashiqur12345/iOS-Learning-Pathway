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
                    Text("You Win").font(.largeTitle).bold()
                    Button(action: {
                        viewModel.playAgain()
                    })
                    {
                        Image(systemName:"arrow.clockwise.circle")
                            .font(.title)
                            .imageScale(.large)
                    }
                }
            }
            else{
                AspectVGrid(items: viewModel.cards, aspectRatio: 2/3){ card in
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
                    shape.strokeBorder(lineWidth:DrawingConstants.lineWidth).foregroundColor(.brown)
                    Text(card.content).font(sizedFont(min(geometry.size.height, geometry.size.width)))
                        
                        .padding(.vertical)
                }
                else if(card.isMatched){
                    shape.opacity(0)
                }
                else{
                    shape.fill(.gray)
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
        CardGameEmojiView(viewModel: viewModel).preferredColorScheme(.light)
        CardGameEmojiView(viewModel: viewModel).previewInterfaceOrientation(.landscapeLeft)
    }
}
