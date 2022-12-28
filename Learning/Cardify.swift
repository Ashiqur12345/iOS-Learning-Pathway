//
//  Cardify.swift
//  Learning
//
//  Created by itiw-mac 256 on 12/27/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var isFaceUp: Bool
    
    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
        
        if(isFaceUp){
            shape
            shape.strokeBorder(lineWidth:DrawingConstants.lineWidth).foregroundColor(.brown)
            content
        }
        else{
            shape.fill(.gray)
        }
    }
    
    struct DrawingConstants{
        static let cornerRadius     : CGFloat = 10
        static let lineWidth        : CGFloat = 3
    }
}


extension View{
    func cardify(isFaceUp: Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

