//
//  User.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 19.07.2024.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = ""
    @Attribute(.externalStorage) var image: Data?
    var createdAt: Date = Date.now
    
    init(name: String = "", image: Data?, createdAt: Date = .now) {
        self.name = name
        self.image = image
        self.createdAt = createdAt
    }
}
