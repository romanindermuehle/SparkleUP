//
//  CreateUserView.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI
import SwiftData
import PhotosUI


struct CreateUserView: View {
    @Environment(\.modelContext) var context
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var imageData: Data?
    @State var name: String = ""
    
    var body: some View {
        Form {
            Section("Create Local Account") {
                if let selectedPhotoData = imageData {
                    Group {
                        Image(data: selectedPhotoData)?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300)
                            .clipShape(Circle())
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                PhotosPicker(selection: $selectedPhoto, matching: .images  ,photoLibrary: .shared()) {
                    Label("Choose your profile image", systemImage: "photo")
                }
                
                if selectedPhoto != nil {
                    Button(role: .destructive) {
                        selectedPhoto = nil
                        imageData = nil
                    } label: {
                        Label("Remove profile image", systemImage: "xmark")
                            .foregroundStyle(.red)
                    }
                }
            }
            Section {
                TextField("Your name", text: $name)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    saveUser()
                    context.insert(Day.init())
                    isOnboarding = false
                }
                .disabled(name.isEmpty)
                .fontWeight(.bold)
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                imageData = data
            }
        }
    }
    
    func saveUser() {
        let user = User(name: name, image: imageData)
        context.insert(user)
    }
}


