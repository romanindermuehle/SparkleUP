//
//  Image.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI

extension Image {
    init?(data: Data) {
        guard let image = UIImage(data: data) else { return nil }
        self = .init(uiImage: image)
    }
}
