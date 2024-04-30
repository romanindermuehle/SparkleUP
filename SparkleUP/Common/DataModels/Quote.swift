//
//  Quote.swift
//
//
//  Created by Roman Indermühle on 20.01.2024.
//

import Foundation
import SwiftData

@Model
class Quote {
    var quote: String
    var author: String
    var image: String
    var alreadySeen: Bool
    var isFavorite: Bool
    var shownAtDay: Day?
    
    init(quote: String, author: String, image: String, alreadySeen: Bool = false, isFavorite: Bool = false, shownAtDay: Day? = nil) {
        self.quote = quote
        self.author = author
        self.image = image
        self.alreadySeen = alreadySeen
        self.isFavorite = isFavorite
        self.shownAtDay = shownAtDay
    }
}

