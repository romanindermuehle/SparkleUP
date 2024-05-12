//
//  QuoteViewTests.swift
//  SparkleUPTests
//
//  Created by Roman Indermühle on 10.05.2024.
//

import XCTest
@testable import SparkleUP

final class QuoteViewTests: XCTestCase {

    func testSuccessfulSelectNewQuote() {
        let quotes: [Quote] = [
            Quote(quote: "Quote1", author: "Author1", image: "Image1", isFavorite: true),
            Quote(quote: "Quote2", author: "Author2", image: "Image2", isFavorite: true),
            Quote(quote: "Quote3", author: "Author3", image: "Image3", isFavorite: true)
        ]
        let quoteView = QuoteView()
        
        let newQuote = quoteView.selectNewQuote(quotes: quotes)
        
        XCTAssertFalse(newQuote == nil)
    }

}
