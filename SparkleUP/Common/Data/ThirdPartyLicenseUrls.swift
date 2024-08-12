//
//  ThirdPartyLicenseUrls.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 11.08.2024.
//

import Foundation

struct ThirdPartyLicenseUrl {
    let id: UUID = UUID()
    var name: String
    var url: URL?
}

struct ThirdPartyLicenseUrls {
    static let urls: [ThirdPartyLicenseUrl] = [
        ThirdPartyLicenseUrl(name: "Vortex(MIT Licence)", url: URL(string: "https://github.com/twostraws/Vortex?tab=MIT-1-ov-file")), ThirdPartyLicenseUrl(name: "Unsplash Licence", url: URL(string: "https://unsplash.com/de/lizenz"))
    ]
}
