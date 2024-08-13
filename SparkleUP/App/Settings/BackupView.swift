//
//  BackupView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 11.08.2024.
//

import SwiftUI

struct BackupView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    @Environment(\.modelContext) var context
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        Form {
            Section {
                Label("Backup feature will be available soon", systemImage: "exclamationmark.triangle")
                    .foregroundStyle(.secondary)
            }
            
            Section {
                Button(role: .destructive) {
                    showDeleteAlert.toggle()
                } label: {
                    Label("Reset database", systemImage: "trash")
                        .foregroundStyle(.red)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Backup")
                    .font(.headline)
                    .fontWeight(.semibold)
                
            }
        }
        .alert("Reset database", isPresented: $showDeleteAlert) {
            Button("Reset", role: .destructive) {
                resetDatabase()
            }
        } message: {
            Text("Do you want to reset the database? This operation is irreversible.")
        }
    }
    
    func resetDatabase() {
        do {
            try context.delete(model: Day.self)
            try context.delete(model: Gratitude.self)
            try context.delete(model: Mood.self)
            try context.delete(model: Quote.self)
            try context.delete(model: Streak.self)
            try context.delete(model: User.self)
            
            isOnboarding = true
        } catch {
            print("Failed to reset database")
        }
    }
}

#Preview {
    BackupView()
}
