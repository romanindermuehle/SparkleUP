//
//  OnboardingView.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentScreen: OnboardingScreen = .welcome
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(OnboardingScreen.allCases, id: \.self) { screen in
                    if screen == currentScreen {
                        screen.destination
                    }
                }
                
                Spacer()
                
                if currentScreen == .welcome {
                    Button {
                        withAnimation(Animation.snappy) {
                            currentScreen = .createUser
                        }
                    } label: {
                        Text("Continue")
                        #if os(iOS)
                            .frame(width: 250, height: 50)
                            .fontWeight(.semibold)
                            .background(.accent)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                        #endif
                    }
                }
            }
            .padding(.bottom, 20)
        }
        
    }
}


