//
//  GratitudeDetailView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 16.08.2024.
//

import SwiftUI

struct GratitudeDetailView: View {
    let gratitude: Gratitude
    
    var body: some View {
        Form {
            Section("I'm grateful for...") {
                Text(gratitude.gratitudeValue1)
            }
            if !gratitude.gratitudeValue2.isEmpty {
                Section("I'm grateful for...") {
                    Text(gratitude.gratitudeValue2)
                }
            }
            
            if !gratitude.gratitudeValue3.isEmpty {
                Section("I'm grateful for...") {
                    Text(gratitude.gratitudeValue3)
                }
            }
        }
    }
}

