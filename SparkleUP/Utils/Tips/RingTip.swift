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
        Text("Set your daily mood, write down what you're grateful for, and read the daily quote to make the ring sparkle.")
    }
    
    var image: Image? {
        Image(systemName: "checkmark.seal.fill")
    }
}
