//
//  HalfCircleShape.swift
//
//
//  Created by Roman Indermühle on 08.02.2024.
//

import SwiftUI

struct HalfCircleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.minX, y: rect.midY), radius: rect.height, startAngle: .degrees(90), endAngle: .degrees(270), clockwise: true)
        return path
    }
}


