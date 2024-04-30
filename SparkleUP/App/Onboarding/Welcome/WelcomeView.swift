//
//  WelcomeView.swift
//  
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .center) {
            
            WelcomeHeader()
                .padding()
            
            Text("Here to help you become aware of your mood, gain positive energy and increase your experience in life.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            InformationContainerView()
                .padding(.bottom)
            
            Spacer()
            
        }
        .padding()
    }
}


