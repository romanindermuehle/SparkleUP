//
//  SparkleRing.swift
//
//
//  Created by Roman Indermühle on 23.01.2024.
//

import SwiftUI
import Foundation
import AVKit

struct SparkleRing: View {
    @Environment(\.dismiss) var dismiss
    @State var player = AVPlayer()
    
    var splitViewVisibility: NavigationSplitViewVisibility?
    
    var screenHeight: Int? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return Int(windowScene.coordinateSpace.bounds.height) - (splitViewVisibility == .detailOnly ? 0: 250)
        }
        return nil
    }
    
    var body: some View {
        VideoPlayer(player: player)
        #if(!os(visionOS))
            .statusBarHidden()
            .rotationEffect(.degrees(-90))
        #endif
        #if(os(visionOS))
            .frame(height: CGFloat(screenHeight ?? 0))
        #endif
            .disabled(true)
            .ignoresSafeArea(.all)
            .background(.black)
            .overlay(alignment: .top) {
                VStack {
                    Text("Congratulations")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Check in completed!")
                        .font(.headline)
                }
                .padding()
                .foregroundStyle(Color.lightMagenta)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(8)) {
                    dismiss()
                }
#if(!os(visionOS))
                if let filePath = Bundle.main.url(forResource: "SparkleRing", withExtension: "mp4") {
                    player = AVPlayer(url: filePath)
                }
#endif
                
#if(os(visionOS))
                if let filePath = Bundle.main.url(forResource: "SparkleRingLandscape", withExtension: "mp4") {
                    player = AVPlayer(url: filePath)
                }
#endif
                
                player.play()
            }
    }
}



#Preview {
    SparkleRing()
}




