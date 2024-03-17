//
//  GratitudeTip.swift
//
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI
import TipKit

struct GratitudeTip: Tip {
    
    var title: Text {
        Text("Stick with it")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("Complet 30 days of daily gratitude to unlock the next level.")
    }
    
    var image: Image? {
        Image(systemName: "square.and.pencil")
    }
}
