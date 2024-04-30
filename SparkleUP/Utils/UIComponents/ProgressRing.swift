//
//  SwiftUIView.swift
//
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI
import SwiftData

struct ProgressRing: View {
    @Environment(\.modelContext) var context
    @Bindable var day: Day
    
    let ringSizeHeight: CGFloat
    let ringSizeWidth: CGFloat
    
    let ringThickness: Double
    let ringHeight: Double
    let ringWidth: Double
    let fontSize: CGFloat
    
    let lightColor: Color = .lightMagenta
    let darkColor: Color = .darkMagenta
    
    
    var body: some View {
        ZStack {
            Text("\(day.percentage * 100, specifier: "%.0f")%")
                .font(.system(size: fontSize, weight: .bold))
            ZStack {
                Circle()
                    .stroke(darkColor.opacity(0.2), lineWidth: ringThickness)
                Circle()
                    .trim(from: 0.0, to: day.percentage <= 1 ? day.percentage : 1.0)
                    .stroke(Color.angularGradientFrom(finalColors: [darkColor, lightColor]), style: .init(lineWidth: ringThickness, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90.0))
                Circle()
                    .trim(from: 0.0, to: day.percentage > 1.0 ? day.percentage - 1.0 :  0.0)
                    .stroke(lightColor, style: .init(lineWidth: ringThickness, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))
            }
            Circle()
                .fill(day.percentage > 0.99 ? lightColor : darkColor)
                .frame(maxWidth: ringWidth, maxHeight: ringHeight)
                .offset(y: -ringSizeHeight / 2)
            
            
            Circle()
                .fill(day.percentage > 1.0 ? lightColor : .clear)
                .frame(maxHeight: ringHeight)
                .offset(y: -ringSizeHeight / 2)
        }
        .frame(maxWidth: ringSizeWidth, maxHeight: ringSizeHeight, alignment: .center)
    }
}

