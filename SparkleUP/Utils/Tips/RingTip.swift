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
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("Set your daily mood and gratitude and read some quotes to make the ring sparkle.")
    }
    
    var image: Image? {
        Image(systemName: "checkmark.seal.fill")
    }
}
