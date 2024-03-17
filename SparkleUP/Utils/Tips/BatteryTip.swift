//
//  BatteryTip.swift
//  
//
//  Created by Roman Indermühle on 12.02.2024.
//

import SwiftUI
import TipKit

struct BatteryTip: Tip {
    
    var title: Text {
        Text("Self awareness")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("The goal of mood tracking is to help you recognize how you are feeling. Self-awareness is the first and most important step in personal growth.")
    }
    
    var image: Image? {
        Image(systemName: "info.circle.fill")
    }
}
