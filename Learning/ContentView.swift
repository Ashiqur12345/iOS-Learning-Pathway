//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: CardGameEmoji
    
    var body: some View {
        
        ZStack(alignment: .center){
            
            ScrollView(){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 93))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(.green)
            
            if(viewModel.isGameWon){
                VStack{
                    Text("You Win").font(.largeTitle).bold().foregroundColor(.green)
                    Button(action: {
                        viewModel.playAgain()
                    })
                    {
                        Image(systemName:"arrow.clockwise.circle")
                            .font(.title)
                            .imageScale(.large)
                            .foregroundColor(.green)
                    }
                }
            }
        }
        .padding(.horizontal)
        
    }
}

struct CardView: View{

    let card: CardGame<String>.Card
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 10)
            
            if(card.isMatched){
                shape.opacity(0)
            }
            else if(card.isFaceUp){
                shape
                shape.strokeBorder(lineWidth:5).foregroundColor(.brown)
                Text(card.content).font(.title).padding(.vertical)
            }
            else{
                shape.fill(.orange)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CardGameEmoji = CardGameEmoji()
        ContentView(viewModel: viewModel).preferredColorScheme(.light)
        ContentView(viewModel: viewModel).previewInterfaceOrientation(.landscapeLeft)
    }
}
