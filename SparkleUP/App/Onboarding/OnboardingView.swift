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
            ForEach(OnboardingScreen.allCases, id: \.self) { screen in
                if screen == currentScreen {
                    screen.destination
                }
            }
            .toolbar {
                
                ToolbarItem(placement: .bottomBar) {
                    if currentScreen == .welcome {
                        Button {
                            withAnimation(Animation.snappy) {
                                currentScreen = .createUser
                            }
                        } label: {
                            Text("Continue")
                                .frame(width: 250, height: 50)
                                .font(.title2)
                                .fontWeight(.bold)
                                .background(Color.accentColor)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding()
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
     
    }
}


