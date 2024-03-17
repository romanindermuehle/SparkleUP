//
//  MoodBarometer.swift
//
//
//  Created by Roman Indermühle on 08.02.2024.
//

import SwiftUI

struct MoodBarometer: View {
    @Binding var moodLevel: Double
    var getColor = MoodLevel.valueToColor
    var levelColor: Double
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 5) {
                GeometryReader { rectangle in
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3)
                    RoundedRectangle(cornerRadius: 15)
                        .padding(5)
                        .frame(width: rectangle.size.width - (rectangle.size.width * (1 - moodLevel)))
                        .foregroundColor(getColor(levelColor))
                }
                HalfCircleShape()
                    .frame(width: geo.size.width / 7, height: geo.size.height / 7)
            }
            .padding(.leading)
            
        }
    }
}

