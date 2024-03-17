//
//  Card.swift
//  
//
//  Created by Roman Indermühle on 24.01.2024.
//

import SwiftUI

struct Card: View {
    
    private var quoteSizeWidth: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.width - 60.0
        } else {
            return UIScreen.main.bounds.width - 80.0
        }
    }
    
    
    private var quoteSizeHeight: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIScreen.main.bounds.height
        } else {
            return UIScreen.main.bounds.height - 215.0
        }
    }
    
    var quote: String
    var author: String
    var image: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: quoteSizeWidth, maxHeight: quoteSizeHeight)
                .clipShape(.rect(cornerRadius: 25))
                .shadow(radius: 8)
            VStack(alignment: .leading, spacing: 5) {
                Text(quote)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Text(author)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .padding(25)

        }
    }
}


