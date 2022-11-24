
import SwiftUI

struct AssignMent1: View {

    var emojies = [
        ["🚗", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚚", "🛻", "🚜", "🚛", "🛺", "🛵", "🏍", "🚔", "🚍", "🚠", "🚖", "🚃", "🚂", "✈️", "🚀", "⛴", "🛳", "🛶", "🚁", "🛩", "🚅", "🚉", "🛴", "🚲"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓", "🏸", "🏒", "🏑", "🥍", "🏏", "🪃", "🥅", "⛳️", "🪁", "🛝", "🏹", "🎣", "🤿", "🥊", "🥋", "🎽", "🛹", "🛼"],
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🦁", "🐯", "🐨", "🐻‍❄️", "🐮", "🐷", "🦆", "🐥", "🦉", "🦇", "🐺", "🐝", "🦅", "🐴", "🦋", "🪲", "🐌", "🪱", "🐞", "🐜", "🦗"]
    ]
    @State var emojiArrayIndex = 0
    var body: some View {
        VStack{
            Text("Memorize!").font(.title)
            cardsHStack
            themeButtons
        }.padding(.horizontal)
    }
    
    var cardsHStack: some View{
        HStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]){
                    ForEach((emojies[emojiArrayIndex].shuffled()), id: \.self, content: { em in
                        AssignMent1CardView(text: em).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
        }.foregroundColor(.green)
    }
    var themeButtons: some View{
        
        HStack(spacing: 25){
            Button {
                emojiArrayIndex = 0
            } label:{
                VStack{
                    Image(systemName:"car").font(.title)
                    Text("Vehicles").font(.body)
                }
            }
            Button {
                emojiArrayIndex = 1
            } label:{
                VStack{
                    Image(systemName:"gamecontroller").font(.title)
                    Text("Games").font(.body)
                }
            }
            Button {
                emojiArrayIndex = 2
            } label:{
                VStack{
                    Image(systemName:"hare").font(.title)
                    Text("Animals").font(.body)
                }
            }
            
        }.font(.largeTitle).padding()
    }
}

struct AssignMent1CardView: View{
    let text : String
    @State var isFaceUp = false
    var body: some View{
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            if(isFaceUp){
                shape
                shape.strokeBorder(lineWidth:5).foregroundColor(.green)
                Text(text).font(.title).padding(.vertical)
            }
            else{
                shape.fill(.orange)
            }
        }.onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}

struct AssignMent1_Previews: PreviewProvider {
    static var previews: some View {
        AssignMent1().preferredColorScheme(.light)
        AssignMent1().previewInterfaceOrientation(.landscapeLeft)
    }
}
