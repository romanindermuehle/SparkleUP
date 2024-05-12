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
                .foregroundStyle(.accent)
                .padding()
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(subTitle)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}


