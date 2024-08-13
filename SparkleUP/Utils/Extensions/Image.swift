//
//  Image.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 10.08.2024.
//

import SwiftUI

extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
    }
}
