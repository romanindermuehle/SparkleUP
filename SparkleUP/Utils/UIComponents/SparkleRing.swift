//
//  SparkleRing.swift
//
//
//  Created by Roman Indermühle on 23.01.2024.
//

import SwiftUI
import Vortex

struct SparkleRing: View {    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Congratulations")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.accent)
            Text("Check in completed!")
                .foregroundStyle(.accent)
                .font(.headline)
            
            VortexView(createSparkle()) {
                Circle()
                    .fill(.white)
                    .frame(width: 16)
                    .tag("circle")
            }
            .edgesIgnoringSafeArea(.all)
            
        }
        .background(.black)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                }
            }
        }
    }
    
    func createSparkle() -> VortexSystem {
        let system = VortexSystem(tags: ["circle"])
        system.birthRate = 800
        system.emissionDuration = 0.5
        system.idleDuration = 0.5
        system.lifespan = 1.5
        system.speed = 1.25
        system.speedVariation = 0.2
        system.angle = .degrees(800)
        system.angleRange = .degrees(5)
        system.acceleration = [0, 3]
        system.dampingFactor = 4
        system.colors = .ramp(.white, .yellow, .yellow.opacity(0))
        system.size = 0.1
        system.sizeVariation = 0.1
        system.stretchFactor = 8
        system.shape = .ellipse(radius: 5)
        return system
    }
}

#Preview {
    SparkleRing()
}


