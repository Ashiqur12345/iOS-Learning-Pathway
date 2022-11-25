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
            ScrollView(){
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 93))], alignment: .leading){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(.green)
            .padding(.horizontal)
    }
}

struct LargeEmojiImage: View{
    let imageName: String
    var body: some View{
        Image(systemName:imageName).imageScale(.large)
    }
}

struct CardView: View{

    let card: CardGame<String>.Card
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 10)
                
            if(card.isFaceUp){
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
