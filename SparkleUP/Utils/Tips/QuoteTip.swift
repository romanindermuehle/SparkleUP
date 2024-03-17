//
//  QuoteTip.swift
//
//
//  Created by Roman Indermühle on 27.01.2024.
//

import SwiftUI
import TipKit

struct QuoteTip: Tip {
    
    var title: Text {
        Text("Swipe left")
            .foregroundStyle(Color.accentColor)
    }
    
    var message: Text? {
        Text("Swipe to the left to mark the quote as favorite")
    }
    
    var image: Image? {
        Image(systemName: "arrow.left")
    }
}
