//
//  Cardify.swift
//  Learning
//
//  Created by itiw-mac 256 on 12/27/22.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 180 : 0
    }
    
    var animatableData: Double{
        get{
            return rotation
        }
        set{
            rotation = newValue
        }
    }
    
    var rotation: Double
    
    func body(content: Content) -> some View {
        
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            
            shape.fill()
            shape.strokeBorder(lineWidth:DrawingConstants.lineWidth).foregroundColor(.brown)
            content
            shape.fill(rotation > 90 ? .clear : .gray)
        }.rotation3DEffect(Angle(degrees: rotation), axis: (0, -1, 0))
        
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

