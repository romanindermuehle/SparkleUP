//
//  MoodLevel.swift
//  
//
//  Created by Roman Indermühle on 22.01.2024.
//

import Foundation
import SwiftUI

struct MoodLevel {
    
    static var valueToColor: (Double) -> Color {
        { value in
            switch value {
            case 0.0...0.2:
                return Color.darkerMagenta.opacity(0.25)
            case 0.2...0.4:
                return Color.darkerMagenta.opacity(0.5)
            case 0.4...0.6:
                return Color.lightMagenta
            case 0.6...0.8:
                return Color.darkMagenta
            case 0.8...1:
                return Color.darkerMagenta
                
            default:
                return Color.clear
            }
        }
    }
    
    static var colorToWord: (Color) -> String {
        { word in
            switch word {
            case Color.darkerMagenta.opacity(0.25):
                return "Upset"
            case Color.darkerMagenta.opacity(0.5):
                return "Sad"
            case Color.lightMagenta:
                return "Indifferent"
            case Color.darkMagenta:
                return "Happy"
            case Color.darkerMagenta:
                return "Fulfilled"
            default:
                return ""
            }
        }
    }
}
