//
//  RingTip.swift
//
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI
import TipKit

struct RingTip: Tip {
    
    var title: Text {
        Text("Complete your daily tasks")
    }
    
    var message: Text? {
        Text("Set your mood, express gratitude, read your quote – watch your ring sparkle!")
    }
    
    var image: Image? {
        Image(systemName: "checkmark.seal.fill")
    }
}
