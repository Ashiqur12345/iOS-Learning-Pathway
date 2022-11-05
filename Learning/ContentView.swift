//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//
import SwiftUI

struct ContentView: View {
    var emojies = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🛝", "🏹", "🎣", "🤿", "🥊", "🥋", "🎽", "🛹", "🛼", "🛷", "⛸", "🥌", "🎿", "⛷", "🏂"]
    @State var emojiCount = 3
    var body: some View {
        VStack{
            HStack{
                ForEach(emojies[0..<emojiCount], id: \.self, content: { em in
                    CardView(text: em)
                })
            }.foregroundColor(.green)
            Spacer()
            HStack{
                Button {
                    emojiCount = min(emojiCount+1, emojies.count)
                } label: {Image(systemName:"plus.circle").imageScale(.large)}
                Spacer()
                Button{
                    emojiCount = max(emojiCount-1, 1)
                } label: {Image(systemName:"minus.circle").imageScale(.large)}
            }.padding(.horizontal).font(.largeTitle)
        }.padding(.horizontal)
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
                shape.stroke(lineWidth:5).foregroundColor(.green)
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
//        ContentView().preferredColorScheme(.dark)
    }
}
