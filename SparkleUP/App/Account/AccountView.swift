//
//  AccountView.swift
//
//
//  Created by Roman Indermühle on 15.01.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct AccountView: View {
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            if let user = users.first {
                Form {
                    Section {
                        VStack(spacing: 8) {
                            if let selectedPhotoData = users.first?.image {
                                Image.init(data: selectedPhotoData)?
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 225, height: 225)
                                    .clipShape(Circle())
                            }
                            
                            Text(user.name)
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text("Created at \(user.createdAt, style: .date)")
                                .font(.caption)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .navigationTitle("Account")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink {
                            AccountEditView(user: user)
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
        }
    }
}



