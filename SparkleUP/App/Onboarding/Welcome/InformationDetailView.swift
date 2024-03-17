//
//  InformationDetailView.swift
//
//
//  Created by Roman Indermühle on 28.01.2024.
//

import SwiftUI

struct InformationDetailView: View {
    var title: String
    var subTitle: String
    var imageName: String
    
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.system(size: 40))
                .scaledToFit()
                .foregroundStyle(Color.accentColor)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                
                Text(subTitle)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


