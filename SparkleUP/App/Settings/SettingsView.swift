//
//  SettingsView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 09.05.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.modelContext) var context
    @State var showDeleteAlert: Bool = false
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink {
                        AcknowledgementsView()
                    } label: {
                        Label("Acknowledgements", systemImage: "info.circle")
                            .foregroundStyle(.accent)
                    }
                }
                Section {
                    Button(role: .destructive) {
                        showDeleteAlert.toggle()
                    } label: {
                        Label("Reset app data", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Reset app data", isPresented: $showDeleteAlert) {
                Button("Reset", role: .destructive) {
                    do {
                        try context.delete(model: Day.self)
                        try context.delete(model: Gratitude.self)
                        try context.delete(model: Mood.self)
                        try context.delete(model: Quote.self)
                        
                        isOnboarding = true

                    } catch {
                        print("Failed to reset app data")
                    }
                }
            } message: {
                Text("Do you want to reset all application data? This operation is irreversible.")
            }
        }
    }
}

#Preview {
    SettingsView()
}
