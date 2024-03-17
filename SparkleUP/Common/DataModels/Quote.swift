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
//    var lightColor: Bool
    var isFavorite: Bool
    
    
    init(quote: String, author: String, image: String, isFavorite: Bool = false) {
        self.quote = quote
        self.author = author
        self.image = image
        self.isFavorite = isFavorite
    }
}

