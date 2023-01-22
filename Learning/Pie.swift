//
//  Pie.swift
//  Learning
//
//  Created by itiw-mac 256 on 12/25/22.
//

import SwiftUI

struct Pie: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: AnimatablePair<Double, Double> {
        get {AnimatablePair(startAngle.radians, endAngle.radians)}
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        let radius = min(rect.width, rect.height)/2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var p = Path()
        p.move(to: center)
        
        p.addLine(to: CGPoint(
                x: center.x + radius * CGFloat(cos(startAngle.radians)),
                y: center.y + radius * CGFloat(sin(startAngle.radians))
            )
        )
        
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        
        p.addLine(to: center)
        
        return p
    }
}
