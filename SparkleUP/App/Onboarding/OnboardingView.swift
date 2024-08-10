//
//  OnboardingView.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

struct OnboardingView: View {
    @State var currentTab: Int = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            WelcomeView(currentTab: $currentTab)
                .tag(0)
            CreateUserView(currentTab: $currentTab)
                .tag(1)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


