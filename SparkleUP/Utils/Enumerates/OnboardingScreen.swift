//
//  OnboardingScreen.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import Foundation
import SwiftUI

enum OnboardingScreen: CaseIterable {
    case welcome
    case createUser
}

extension OnboardingScreen {
    @ViewBuilder
    var destination: some View {
        switch self {
        case .welcome:
            WelcomeView()
        case .createUser:
            CreateUserView()
        }
    }
}
