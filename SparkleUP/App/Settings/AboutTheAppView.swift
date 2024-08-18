//
//  AboutTheAppView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 11.08.2024.
//

import SwiftUI

struct AboutTheAppView: View {
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 8) {
                Text("SparkleUP")
                    .font(.system(size: 64, weight: .black))
                    .foregroundStyle(.accent)
                    .padding(.bottom)
                
                Text("Version: \(appVersion) (\(buildNumber))")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                Text("Made with ❤️ in Switzerland")
                    .font(.title)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding()
                
                Spacer()
                
                Image(.portraitRoman)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 145, maxHeight: 145)
                    .clipShape(Circle())
                Text("Roman Indermühle")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Developer")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                
                Grid() {
                    GridRow {
                        if let mastodonURL = SocialMediaUrls.mastodonURL {
                            Link(destination: mastodonURL) {
                                HStack {
                                    Image(.mastodonPurple)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Mastodon")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                        
                        if let twitterURL = SocialMediaUrls.twitterURL {
                            Link(destination: twitterURL) {
                                HStack {
                                    Image(.xLogoBlack)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Twitter")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                    }
                    GridRow {
                        if let linkedInRIURL = SocialMediaUrls.linkedInRIURL {
                            Link(destination: linkedInRIURL) {
                                HStack {
                                    Image(.inBlue128)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("LinkedIn")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                        
                        if let websiteRIURL = SocialMediaUrls.websiteRIURL {
                            Link(destination: websiteRIURL) {
                                HStack {
                                    Image(systemName: "link")
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Website")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.top, 15)
                
                Spacer(minLength: 50)
                
                Image(.portraitCorinne)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 145, maxHeight: 145)
                    .clipShape(Circle())
                
                Text("Corinne Furch")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Mindset Business Expert ")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                
                Grid() {
                    GridRow {
                        if let linkedInCFURL = SocialMediaUrls.linkedInCFURL {
                            Link(destination: linkedInCFURL) {
                                HStack {
                                    Image(.inBlue128)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("LinkedIn")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                        
                        if let facebookURL = SocialMediaUrls.facebookURL {
                            Link(destination: facebookURL) {
                                HStack {
                                    Image(.facebookLogo)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Facebook")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                    }
                    GridRow {
                        if let instagramURL = SocialMediaUrls.instagramURL {
                            Link(destination: instagramURL) {
                                HStack {
                                    Image(.instagramGlyphGradient)
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Instagram")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                        
                        if let websiteCFURL = SocialMediaUrls.websiteCFURL {
                            Link(destination: websiteCFURL) {
                                HStack {
                                    Image(systemName: "link")
                                        .resizable()
                                        .frame(maxWidth: 28, maxHeight: 28)
                                        .scaledToFit()
                                    Text("Website")
                                        .font(.headline)
                                        .tint(.primary)
                                }
                                .padding()
                            }
                            .background(Color(.systemGray5))
                            .clipShape(Capsule())
                        }
                    }
                }
                .padding(.top, 15)
                
                Spacer(minLength: 50)
                
                GroupBox {
                    VStack(spacing: 8) {
                        ForEach(ThirdPartyLicenseUrls.urls, id: \.id) { element in
                            HStack {
                                if let url = element.url {
                                    Link(destination: url) {
                                        Label(element.name, systemImage: "link")
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.top, 4)
                } label: {
                    Text("Third Party Licenses")
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("About the app")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    AboutTheAppView()
}
