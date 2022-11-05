//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            CardView(text: "⚽️", isFaceUp: true)
            CardView(text: "🏀")
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
                shape.fill(.orange)
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
