//
//  QuoteView.swift
//
//
//  Created by Roman Indermühle on 20.01.2024.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    @Query var days: [Day]
    @Query(filter: #Predicate<Quote> { quote in
        quote.isFavorite
    }) var quotes: [Quote]
    
    @State var showAddQuote = false
    
    var body: some View {
        VStack {
            if quotes.isEmpty {
                ContentUnavailableView {
                    Label("No quotes chosen yet", systemImage: "quote.bubble")
                } description: {
                    Text("Suggested quotes are available. If you want to add them, mark them as favorites.")
                } actions: {
                    Button() {
                        showAddQuote.toggle()
                    } label: {
                        Text("Add Quote")
                            .padding(5)
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(quotes) { quote in
                            Card(quote: quote.quote, author: quote.author, image: quote.image)
                                .containerRelativeFrame(.horizontal)
                                .scrollTransition(axis: .horizontal) { content, phase in
                                    content
                                        .rotation3DEffect(.degrees(phase.value * -30.0), axis: (x: phase.value, y: 1, z: 0))
                                        .scaleEffect(x: phase.isIdentity ? 1 : 0.8, y: phase.isIdentity ? 1 : 0.8)
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAddQuote.toggle()
                } label: {
                    Image(systemName: "rectangle.stack.badge.plus")
                }
            }
        }
        .sheet(isPresented: $showAddQuote) {
            NavigationStack {
                QuoteAddView()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            if let day = days.last {
                if day.tasksDone.contains(where: { $0 == "quoteDone" }) {
                    return
                } else {
                    day.tasksDone.append("quoteDone")
                    
                    if day.percentage != 1 {
                        day.percentage += 0.3
                    } else {
                        return
                    }
                }
            }
        }
        .navigationTitle("Your inspirational Quotes")
        .scrollIndicators(.hidden)
        .contentMargins(20)
    }
}


