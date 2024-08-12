//
//  QuoteView.swift
//
//
//  Created by Roman Indermühle on 20.01.2024.
//

import SwiftUI
import SwiftData

struct QuoteView: View {
    @Query(sort: \Day.startedAt) var days: [Day]
    @Query(filter: #Predicate<Quote> { quote in
        quote.isFavorite
    }) var quotes: [Quote]
    
    @State var showAddQuote = false
    
    var body: some View {
        VStack(alignment: .center) {
            if quotes.isEmpty {
                ContentUnavailableView {
                    Label("No favorited quotes", systemImage: "quote.bubble")
                } description: {
                    Text("Suggested quotes are available. First, favorite a quote so it'll show up here.")
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
                if let quoteOfTheDay = days.last?.quoteOfTheDay {
                    Card(quote: quoteOfTheDay.quote, author: quoteOfTheDay.author, image: quoteOfTheDay.image)
                }
                
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
        .sheet(isPresented: $showAddQuote, onDismiss: {
            if let day = days.last {
                if day.quoteOfTheDay == nil {
                    if let newQuote = selectNewQuote(quotes: quotes) {
                        newQuote.shownAtDay = day
                        day.quoteOfTheDay = newQuote
                    }
                }
            }
        }) {
            NavigationStack {
                QuoteAddView()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .task {
            if let day = days.last {
                if day.quoteOfTheDay == nil {
                    if let newQuote = selectNewQuote(quotes: quotes) {
                        newQuote.shownAtDay = day
                        day.quoteOfTheDay = newQuote
                    }
                }
            }
            
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
        .navigationTitle("Your daily Quote")
        .scrollIndicators(.hidden)
        .contentMargins(20)
    }
    
    func selectNewQuote(quotes: [Quote]) -> Quote? {
        quotes.shuffled().first
    }
}



