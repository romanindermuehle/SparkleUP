//
//  SparkleRing.swift
//
//
//  Created by Roman Indermühle on 23.01.2024.
//

import SwiftUI
import AVKit

struct SparkleRing: View {
    
    @State private var player = AVPlayer()
    
    @Binding var showSparkle: Bool
    
    @Environment(\.dismiss) var dismiss
    private let CardSize: CGFloat = UIScreen.main.bounds.width - 60.0
    
    var body: some View {
        
        VideoPlayer(player: player)
            .disabled(true)
            .onAppear {
                if let filePath = Bundle.main.url(forResource: "SparkleRing(Hoch)", withExtension: "mp4") {
                    player = AVPlayer(url: filePath)
                }
                
                player.play()
                
                Task { @MainActor in
                    try await Task.sleep(for: .seconds(7))
                    showSparkle.toggle()
                }
                
            }
            .ignoresSafeArea(.all)
            .statusBarHidden()
            .rotationEffect(.degrees(-90))
            .background(.black)
            .overlay(alignment: .top) {
                VStack {
                    Text("Congratulations")
                    Text("Check in completed!")
                }
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(Color.neonMagenta)
            }
    }
}




