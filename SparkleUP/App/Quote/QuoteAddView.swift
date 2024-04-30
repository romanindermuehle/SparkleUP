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
        List {
            Section {
                TipView(quoteTip, arrowEdge: .bottom)
                    .padding()
                    #if os(iOS)
                    .tipBackground(Color.accentColor.opacity(0.1))
                    #endif
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            
            ForEach(quotes) { quote in
                VStack(alignment: .leading) {
                    HStack {
                        Button {
                            animationToggled.toggle()
                            quote.isFavorite.toggle()
                        } label: {
                            Image(systemName: quote.isFavorite ? "star.fill" : "star.slash.fill")
                                .font(.title)
                                .foregroundStyle(quote.isFavorite ? Color.accentColor : Color.gray)
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
                                .tint(quote.isFavorite ? Color.gray : Color.accentColor)
                        }
                        
                    }
                }
            }
        }
        
        .navigationTitle("Add Quote")
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
        .onAppear {
            if quotes.isEmpty {
                for quote in SampleData.quotes {
                    context.insert(quote)
                }
            }
        }
    }
}

