//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct ContentView: View {
    var emojies = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🛝", "🏹", "🎣", "🤿", "🥊", "🥋", "🎽", "🛹", "🛼", "🛷", "⛸", "🥌", "🎿"]
    @State var emojiCount = 34
    var body: some View {
        VStack{
            HStack{
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]){
                        ForEach(emojies[0..<emojiCount], id: \.self, content: { em in
                            CardView(text: em).aspectRatio(2/3, contentMode: .fit)
                        })
                    }
                }
            }.foregroundColor(.green)
            Spacer()
            HStack{
                Button {
                    emojiCount = min(emojiCount+1, emojies.count)
                } label:{LargeEmojiImage(imageName: "plus.circle")}
                Spacer()
                Button{
                    emojiCount = max(emojiCount-1, 1)
                } label: {LargeEmojiImage(imageName: "minus.circle")}
            }.padding(.horizontal).font(.largeTitle)
        }.padding(.horizontal)
    }
}

struct LargeEmojiImage: View{
    let imageName: String
    var body: some View{
        Image(systemName:imageName).imageScale(.large)
    }
}

struct CardView: View{
    let text : String
    @State var isFaceUp = false
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 10)
            if(isFaceUp){
                shape
                shape.strokeBorder(lineWidth:5).foregroundColor(.green)
                Text(text)
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            else{
                shape.fill(.orange)
            }
        }.onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}
