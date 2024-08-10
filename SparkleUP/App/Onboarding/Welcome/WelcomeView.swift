//
//  WelcomeView.swift
//  
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var currentTab: Int
    
    var body: some View {
        VStack(alignment: .center) {
            
            WelcomeHeader()
                .padding()
            
            Text("Here to help you become aware of your mood, gain positive energy and increase your experience in life.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
            
            Spacer()
            
            InformationContainerView()
                .padding(.bottom)
            
            Spacer()
            
            Button {
                currentTab += 1
                print(currentTab)
            } label: {
                Text("Continue")
                    .frame(width: 250, height: 50)
#if (os(iOS))
                    .fontWeight(.semibold)
                    .background(.accent)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
#endif
            }
            .padding(.bottom, 40)
            
        }
        .padding()
    }
}


