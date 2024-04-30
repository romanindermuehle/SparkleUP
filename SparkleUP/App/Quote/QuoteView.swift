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
        quote.isFavorite && !quote.alreadySeen
    }) var quotes: [Quote]
    @Query(filter: #Predicate<Quote> { quote in
        quote.isFavorite
    }) var quotesFav: [Quote]
    
    @State var showAddQuote = false
    @State var randomQuote: Quote?
    
    var body: some View {
        VStack(alignment: .center) {
            if quotes.isEmpty {
                ContentUnavailableView {
                    Label("No favorite quotes", systemImage: "quote.bubble")
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
                
                if let randomQuote {
                    Card(quote: randomQuote.quote, author: randomQuote.author, image: randomQuote.image)
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
        .sheet(isPresented: $showAddQuote) {
            NavigationStack {
                QuoteAddView()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            print(randomQuote?.author ?? "")
            
            if let day = days.last {
                selectNewQuote(day: day)
                if day.QuoteOfTheDay == nil {
                    randomQuote?.shownAtDay = day
                    day.QuoteOfTheDay = randomQuote
                } else {
                    randomQuote = day.QuoteOfTheDay
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
    
    func selectNewQuote(day: Day) {
        let currentDate = Date()
        
        let isExpired = day.startedAt.formatted(date: .abbreviated, time: .omitted) != currentDate.formatted(date: .abbreviated, time: .omitted)
        
        print("currentDate:\(currentDate.formatted(date: .abbreviated, time: .omitted))")
        print("startedAt:\(day.startedAt.formatted(date: .abbreviated, time: .omitted))")
        
        if isExpired || day.QuoteOfTheDay == nil {
            if quotes.count > 0 {
                randomQuote = quotes.randomElement()
                randomQuote?.alreadySeen = true
                print("Quotes: \(quotes.count)")
            } else if quotes.count == 0 {
                quotesFav.forEach { quote in
                    quote.alreadySeen = false
                    randomQuote = quotes.randomElement()
                    print("Quotes: \(quotes.count)")
                }
            } else {
                return
            }
            print(days.count)
        } else {
            print("\(isExpired)")
        }
    }
}


