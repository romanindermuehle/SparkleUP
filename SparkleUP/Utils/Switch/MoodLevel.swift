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
            case 0.0...0.25:
                return Color.red
            case 0.25...0.5:
                return Color.orange
            case 0.5...0.75:
                return Color.yellow
            case 0.75...1:
                return Color.green
                
            default:
                return Color.clear
            }
        }
    }
    
    static var colorToWord: (Color) -> String {
        { word in
            switch word {
            case Color.red:
                return "Sad"
            case Color.orange:
                return "Indifferent"
            case Color.yellow:
                return "Happy"
            case Color.green:
                return "Fulfilled"
            default:
                return ""
            }
        }
    }
}
