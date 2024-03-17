//
//  PlusButton.swift
//
//
//  Created by Roman Indermühle on 20.01.2024.
//

import SwiftUI

struct PlusButton: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Image(systemName: "plus.circle.fill")
            .font(.system(size: 64))
            .symbolRenderingMode(.palette)
            .foregroundStyle(Color.buttonColorForeground, Color.buttonColorBackground)
            .shadow(radius: 10)
    }
}

