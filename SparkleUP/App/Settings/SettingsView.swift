//
//  SettingsView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 09.05.2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Query(sort: \User.createdAt) var users: [User]
    @Environment(\.modelContext) var context
    @State var path: NavigationPath = NavigationPath()
    
    @State var mailtoReportURL: URL?
    @State var mailtoFeedbackURL: URL?
    let appStoreURL: URL? = URL(string: "itms-apps://itunes.apple.com/app/id\(6502578066)?mt=8&action=write-review")
    let privacyPolicyURL: URL? = URL(string: "https://www.romanindermuehle.ch/posts/privacypolicysparkleup")
    
    var body: some View {
        NavigationStack(path: $path) {
            Form {
                Section {
                    if let user = users.first {
                        NavigationLink(value: user) {
                            HStack {
                                if let profileImage = user.image {
                                    Image.init(data: profileImage)?
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 65, height: 65)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(.accent)
                                        .frame(width: 65, height: 65)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(user.name)
                                        .font(.title3)
                                        .fontWeight(.medium)
                                    Text("Created at \(user.createdAt, style: .date)")
                                        .font(.caption)
                                }
                                .padding(.leading)
                            }
                        }
                    } else {
                        Button {
                            createNewUser()
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.accent)
                                    .frame(width: 65, height: 65)
                                
                                Text("Let us know what we can call you")
                                    .font(.headline)
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                            }
                        }
                    }
                }
                
                Section("Data") {
                    NavigationLink {
                        BackupView()
                    } label: {
                        Label("Backup", systemImage: "cylinder.split.1x2")
                    }
                    
                }
                
                Section("Contact & Support") {
                    
                    if let mailtoReportURL {
                        Link(destination: mailtoReportURL) {
                            Label("Report a problem", systemImage: "exclamationmark.bubble")
                                .tint(.primary)
                        }
                    }
                    
                    if let mailtoFeedbackURL {
                        Link(destination: mailtoFeedbackURL) {
                            Label("Share your feedback", systemImage: "bubble.left.and.bubble.right")
                                .tint(.primary)
                        }
                    }
                    
                    if let appStoreURL {
                        Link(destination: appStoreURL) {
                            Label("Your positiv review supports us", systemImage: "star.bubble")
                                .tint(.primary)
                        }
                    }
                }
                
                Section("More") {
                    NavigationLink {
                        AboutTheAppView()
                    } label: {
                        Label("About the app", systemImage: "info.circle")
                    }
                    
                    if let privacyPolicyURL {
                        Link(destination: privacyPolicyURL) {
                            Label("Privacy Policy", systemImage: "shield.lefthalf.filled.badge.checkmark")
                                .tint(.primary)
                        }
                    }
                }
            }
            .navigationDestination(for: User.self) { user in
                UserModifyView(user: user)
            }
            .navigationTitle("Settings")
            .task {
                mailtoReportURL = createMailtoReportURL()
                mailtoFeedbackURL = createMailtoFeedbackURL()
            }
        }
    }
    
    func createMailtoReportURL() -> URL? {
        let email = "contact@romanindermuehle.ch"
        let subject = "SparkleUP: Report Problem"
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
        let iosVersion = UIDevice.current.systemVersion
        let body = """
               
               
               -----
               SparkleUP-Version: \("\(appVersion) (\(buildNumber))")
               iOS-Version: \(iosVersion)
               """
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let subject = encodedSubject, let body = encodedBody else {
            return nil
        }
        
        let mailtoURLString = "mailto:\(email)?subject=\(subject)&body=\(body)"
        return URL(string: mailtoURLString)
    }
    
    func createMailtoFeedbackURL() -> URL? {
        let email = "contact@romanindermuehle.ch"
        let subject = "SparkleUP: Feedback"
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let subject = encodedSubject else {
            return nil
        }
        
        let mailtoURLString = "mailto:\(email)?subject=\(subject)"
        return URL(string: mailtoURLString)
    }
    
    
    
    func createNewUser() {
        let user = User.init(image: nil)
        context.insert(user)
        
        path.append(user)
    }
}



