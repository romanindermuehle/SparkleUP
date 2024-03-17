//
//  InformationContainerView.swift
//
//
//  Created by Roman Indermühle on 28.01.2024.
//

import SwiftUI

struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(
                title: "Cultivate habits",
                subTitle: "Start building the foundation for a healthier and happier lifestyle.",
                imageName: "trophy.fill"
            )
            InformationDetailView(
                title: "Self-reflection",
                subTitle: "Track your daily mood and moments of gratitude.",
                imageName: "brain.head.profile.fill"
            )
            InformationDetailView(
                title: "SparkleUP",
                subTitle: "Get the joyful life you deserve.",
                imageName: "sparkles"
            )
        }
        .padding(.horizontal)
    }
}


