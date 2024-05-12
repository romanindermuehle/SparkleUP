//
//  OnboardingView.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.modelContext) var context
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                WelcomeView()
                
                Spacer()
                
                Button {
                    context.insert(Day.init())
                    isOnboarding = false
                } label: {
                    Text("Let's Start")
#if os(iOS)
                        .frame(width: 250, height: 50)
                        .fontWeight(.semibold)
                        .background(.accent)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
#endif
                }
            }
            .padding(.bottom, 20)
        }
        
    }
}


