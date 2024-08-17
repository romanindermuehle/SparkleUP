//
//  GratitudeListView.swift
//
//
//  Created by Roman Indermühle on 18.01.2024.
//

import SwiftUI
import SwiftData

struct GratitudeListView: View {
    @Query(sort: \Gratitude.createdAt, order: .reverse) var gratitudes: [Gratitude]
    @Environment(\.modelContext) var context
    
    var body: some View {
        VStack {
            if gratitudes.isEmpty {
                ContentUnavailableView {
                    Label("No recorded gratitude", systemImage: "square.and.pencil")
                } description: {
                    Text("You haven't recorded any gratitude yet.")
                } actions: {
                    NavigationLink(value: true) {
                        Text("Add Gratitude")
                            .padding(5)
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                List {
                    ForEach(gratitudes, id: \.self) { gratitude in
                        NavigationLink(value: GratitudeDestination.detail(gratitude)) {
                            VStack(alignment: .leading) {
                                Text(gratitude.gratitudeValue1)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                Text(gratitude.createdAt, style: .date)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                context.delete(gratitude)
                            } label: {
                                Image(systemName: "trash")
                            }
                            
                        }
                    }
                }
            }
        }
        .navigationTitle("Your Gratitudes")
        .navigationDestination(for: GratitudeDestination.self) { destination in
            switch destination {
            case .add:
                GratitudeAddView(gratitudeValue1: "", gratitudeValue2: "", gratitudeValue3: "")
            case .detail(let gratitude):
                GratitudeDetailView(gratitude: gratitude)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(value: GratitudeDestination.add) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

