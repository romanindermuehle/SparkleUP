//
//  AccountEditView.swift
//
//
//  Created by Roman Indermühle on 17.01.2024.
//

import SwiftUI
import PhotosUI

struct AccountEditView: View {
    
    @Bindable var user: User
    
    @State private var selectedPhoto: PhotosPickerItem?
    
    var body: some View {
        Form {
            Section {
                if let selectedPhotoData = user.image {
                    Group {
                        Image(data: selectedPhotoData)?
                            .resizable()
                            .scaledToFill()
                            .frame(width: 300, height: 300, alignment: .center)
                            .clipShape(Circle())
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    if user.image != nil {
                        Button(role: .destructive) {
                            selectedPhoto = nil
                            user.image = nil
                        } label: {
                            Label("Remove profile image", systemImage: "xmark")
                                .foregroundStyle(.red)
                        }
                    }
                }
                PhotosPicker(selection: $selectedPhoto, matching: .images  ,photoLibrary: .shared()) {
                    Label("Choose your profile image", systemImage: "photo")
                }
            }
            
            Section {
                TextField("Your name", text: $user.name)
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                user.image = data
            }
        }
    }
}


