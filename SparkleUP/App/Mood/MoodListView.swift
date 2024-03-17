//
//  MoodListView.swift
//
//
//  Created by Roman Indermühle on 21.01.2024.
//

import SwiftUI
import SwiftData

struct MoodListView: View {
    @Query(sort: \Mood.addedAt, order: .reverse) var moods: [Mood]
    @Environment(\.modelContext) var context
    
    private var minimum = 0.0
    private var maximum = 100.0
    var getWord = MoodLevel.colorToWord
    var getColor = MoodLevel.valueToColor
    
    var body: some View {
        VStack {
            if moods.isEmpty {
                ContentUnavailableView {
                    Label("No recorded mood", systemImage: "square.and.pencil")
                } description: {
                    Text("You haven't entered a mood yet.")
                } actions: {
                    NavigationLink(value: true) {
                        Text("Add Mood")
                            .padding(5)
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            } else {
                List {
                    ForEach(moods, id: \.self) { mood in
                        NavigationLink(value: mood) {
                            HStack {
                                Gauge(value: mood.moodLevel * 100, in: minimum...maximum) {
                                    Image(systemName: "percent")
                                } currentValueLabel: {
                                    Text("\(mood.moodLevel * 100, specifier: "%.0f")")
                                }
                                .gaugeStyle(.accessoryCircular)
                                .tint(Gradient(colors: [.darkMagenta.opacity(0.25), .darkMagenta.opacity(0.5), .lightMagenta, .darkMagenta, .darkerMagenta]))
                                
                                VStack(alignment: .leading) {
                                    Text("\(getWord(getColor(mood.moodLevel)))")
                                        .font(.headline)
                                        .foregroundStyle(getColor(mood.moodLevel))
                                    Text(mood.addedAt, style: .date)
                                }
                                
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                context.delete(mood)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Your Mood")
        .navigationDestination(for: Mood.self) { mood in
            MoodModifyView(mood: .constant(mood), moodLevel: mood.moodLevel, isEditing: true)
        }
        .navigationDestination(for: Bool.self) { _ in
            MoodModifyView(mood: .constant(nil), moodLevel: 0.0, isEditing: false)
        }
        .toolbar(.hidden, for: .tabBar)
        .overlay(alignment: .bottom) {
            NavigationLink(value: true) {
                PlusButton()
            }
            .padding(.bottom)
        }
    }
}

