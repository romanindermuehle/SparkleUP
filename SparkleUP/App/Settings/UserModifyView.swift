//
//  UserModifyView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 10.08.2024.
//

import SwiftUI
import PhotosUI

struct UserModifyView: View {
    @Bindable var user: User
    
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var isPhotoMenuShowing: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 8) {
                if let selectedPhotoData = user.image {
                    Image.init(data: selectedPhotoData)?
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.accent)
                        .frame(width: 120, height: 120)
                }
                
                
                Menu {
                    Button {
                        isPhotoMenuShowing.toggle()
                    } label: {
                        Label("Photo library", systemImage: "photo.on.rectangle.angled")
                    }
                    Button(role: .destructive) {
                        selectedPhoto = nil
                        user.image = nil
                    } label: {
                        Label("Remove photo", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                    .disabled(user.image == nil)
                } label: {
                    Text("Change photo")
                        .font(.headline)
                }
                .photosPicker(isPresented: $isPhotoMenuShowing, selection: $selectedPhoto, matching: .images, photoLibrary: .shared())
                
                
                Text("Created at \(user.createdAt, style: .date)")
                    .font(.caption)
            }
            .padding(.bottom)
            
            TextField("Your name", text: $user.name)
                .textFieldStyle(.roundedBorder)
                .padding()
            
            Spacer()
            
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                user.image = data
            }
        }
    }
}

