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
    
    @State var percentage: Double = 0.0
    
    let ringSizeHeight: CGFloat
    let ringSizeWidth: CGFloat
    
    let ringThickness: Double
    let ringHeight: Double
    let ringWidth: Double
    
    let lightColor: Color = Color.lightMagenta
    let darkColor: Color = Color.accentColor
    let darkerColor: Color = Color.darkerMagenta
    
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .stroke(lightColor.opacity(0.2), lineWidth: ringThickness)
                Circle()
                    .trim(from: 0.0, to: percentage <= 1 ? percentage : 1.0)
                    .stroke(Color.angularGradientFrom(finalColors: [lightColor, darkColor]), style: .init(lineWidth: ringThickness, lineCap: .round, lineJoin: .round))
                    .rotationEffect(.degrees(-90.0))
                Circle()
                    .fill(percentage > 0.99 ? darkColor : lightColor)
                    .frame(width: ringWidth, height: ringSizeHeight, alignment: .center)
                    .offset(y: -ringSizeHeight/2)
                Circle()
                    .trim(from: 0.0, to: percentage > 1.0 ? percentage - 1.0 :  0.0)
                    .stroke(Color.angularGradientFrom(finalColors: [darkColor, darkerColor]), style: .init(lineWidth: ringThickness, lineCap: .round))
                    .rotationEffect(.degrees(-90.0))
            }
            .animation(.bouncy(duration: 0.3), value: percentage)
            
            Circle()
                .fill(percentage > 1.0 ? darkColor : .clear)
                .frame(height: ringHeight)
                .offset(y: -ringSizeHeight/2)
            
        
        }
        .onAppear {
            withAnimation(Animation.easeOut(duration: 3)) {
                percentage = day.percentage
            }
        }
        .frame(maxWidth: ringSizeWidth, maxHeight: ringSizeHeight, alignment: .center)
    }
}

