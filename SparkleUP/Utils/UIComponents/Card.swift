//
//  Card.swift
//
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI

struct Card: View {
    var quote: String
    var author: String
    var image: String
    
    var splitViewVisibility: NavigationSplitViewVisibility?
    
    var screenWidth: Int? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Int(windowScene.coordinateSpace.bounds.width) - (splitViewVisibility == .detailOnly ? 0: 50)
        }
        return nil
    }
    
    var screenHeight: Int? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Int(windowScene.coordinateSpace.bounds.height) - (splitViewVisibility == .detailOnly ? 0: 250)
        }
        return nil
    }
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: CGFloat(screenWidth ?? 0), maxHeight: CGFloat(screenHeight ?? 0))
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(radius: 8)
            VStack(alignment: .leading, spacing: 5) {
                Text(quote)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(author)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 50)
        }
    }
}


