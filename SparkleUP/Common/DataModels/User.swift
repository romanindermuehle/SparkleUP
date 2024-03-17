//
//  User.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    @Attribute(.externalStorage) var image: Data?
    var createdAt: Date
    
    init(name: String, image: Data?, createdAt: Date = .now) {
        self.name = name
        self.image = image
        self.createdAt = createdAt
    }
}
