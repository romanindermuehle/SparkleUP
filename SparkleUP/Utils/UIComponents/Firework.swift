//
//  Firework.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 30.04.2024.
//

import SwiftUI
import Vortex

struct Firework: View {
    var body: some View {
        VStack {
            VortexView(createFirework()) {
                Circle()
                    .fill(.white)
                    .frame(width: 16)
                    .tag("circle")
            }
            .edgesIgnoringSafeArea(.all)
        }
        .background(.black)
    }
    
    func createFirework() -> VortexSystem {
        let sparkles = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onUpdate,
            emissionLimit: 1,
            lifespan: 0.5,
            speed: 0.04,
            angleRange: .degrees(90),
            size: 0.2
        )

        let explosion = VortexSystem(
            tags: ["circle"],
            spawnOccasion: .onDeath,
            position: [0.5, 1],
            birthRate: 100_000,
            emissionLimit: 500,
            speed: 0.2,
            speedVariation: 0.8,
            angleRange: .degrees(360),
            acceleration: [0, 1.5],
            dampingFactor: 4,
            colors: .randomRamp(
                [.white, .yellow, .yellow],
                [.white, .yellow, .yellow],
                [.white, .purple, .purple],
                [.white, .orange, .orange],
                [.white, .pink, .pink]
            ),
            size: 0.4,
            sizeVariation: 0.2,
            sizeMultiplierAtDeath: 0
        )
        
        let mainSystem = VortexSystem(tags: ["circle"])
        mainSystem.secondarySystems = [sparkles, explosion]
        mainSystem.position = [0.5, 1]
        mainSystem.birthRate = 2
        mainSystem.emissionLimit = 30
        mainSystem.speed = 1.5
        mainSystem.speedVariation = 0.75
        mainSystem.angleRange = .degrees(60)
        mainSystem.dampingFactor = 2
        mainSystem.size = 0.15
        mainSystem.stretchFactor = 4

        
        
        return mainSystem
    }
}

#Preview {
    Firework()
}
