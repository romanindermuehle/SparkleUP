//
//  QuoteAddView.swift
//
//
//  Created by Roman Indermühle on 27.01.2024.
//

import SwiftUI
import SwiftData
import TipKit

struct QuoteAddView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query(sort: \Quote.quote) var quotes: [Quote]
    
    var quoteTip = QuoteTip()
    
    @State private var animationToggled: Bool = false
    
    
    var body: some View {
        VStack {
            if quotes.isEmpty {
                ContentUnavailableView {
                    Label("No quotes loaded yet", systemImage: "icloud.and.arrow.down")
                } description: {
                    Text("First, tap the \"Load Quotes\" button to load all suggested quotes.")
                } actions: {
                    Button() {
                        for quote in QuoteSampleData.quotes {
                            context.insert(quote)
                        }
                        
                    } label: {
                        Text("Load Quotes")
                            .padding(5)
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                VStack {
                    TipView(quoteTip, arrowEdge: .bottom)
                        .padding()
                    List {
                        ForEach(quotes) { quote in
                            VStack(alignment: .leading) {
                                HStack {
                                    Button {
                                        animationToggled.toggle()
                                        quote.isFavorite.toggle()
                                    } label: {
                                        Image(systemName: quote.isFavorite ? "star.fill" : "star.slash.fill")
                                            .font(.title)
                                            .foregroundStyle(quote.isFavorite ? .accent : .gray)
                                    }
                                    .buttonStyle(.borderless)
                                    .symbolEffect(.bounce, value: animationToggled)
                                    
                                    VStack(alignment: .leading) {
                                        Text(quote.quote)
                                        Text(quote.author)
                                    }
                                }
                                .swipeActions {
                                    Button {
                                        quote.isFavorite.toggle()
                                    } label: {
                                        Image(systemName: quote.isFavorite ? "star.slash.fill" : "star.fill")
                                            .font(.title)
                                            .tint(quote.isFavorite ? .gray : .accent)
                                    }
                                    
                                }
                            }
                        }
                     
                    }
                }
            }
        }
        .navigationTitle("Choose Quotes")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
                .fontWeight(.bold)
            }
        }
    }
}

