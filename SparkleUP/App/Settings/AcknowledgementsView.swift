//
//  LicenceView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 09.05.2024.
//

import SwiftUI

struct AcknowledgementsView: View {
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Project name:")
                        Text("Vortex")
                            .font(.headline)
                    }
                    
                    HStack {
                        Text("Created from:")
                        Text("Paul Hudson")
                            .font(.headline)
                    }
                    HStack {
                        Link("Vortex licence(MIT)", destination: URL(string: "https://github.com/twostraws/Vortex?tab=MIT-1-ov-file")!)
                        Image(systemName: "link")
                            .foregroundStyle(.accent)
                    }
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("Quote images from:")
                        Text("Unsplash")
                            .font(.headline)
                    }
                    
                    HStack {
                        Link("Unsplash licence", destination: URL(string: "https://unsplash.com/privacy")!)
                        Image(systemName: "link")
                            .foregroundStyle(.accent)
                    }
                }
            }
        }
        .navigationTitle("Acknowledgements")
    }
}

#Preview {
    AcknowledgementsView()
}
