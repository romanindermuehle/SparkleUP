//
//  Color.swift
//
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI

extension Color {
    static func angularGradientFrom(finalColors: [Color]) -> AngularGradient {
        return AngularGradient(gradient: Gradient(colors: finalColors), center: .center)
    }
}
