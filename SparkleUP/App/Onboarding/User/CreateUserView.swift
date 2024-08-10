//
//  CreateUserView.swift
//  iLibrary
//
//  Created by Roman Indermühle on 15.06.2024.
//

import SwiftUI
import SwiftData

struct CreateUserView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    
    @State private var name: String = ""
    @FocusState private var isFocused: Bool
    @Binding var currentTab: Int
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            VStack {
                Text("Hello Voyager!")
                    .font(.system(size: 36))
                    .fontWeight(.black)
                    .foregroundStyle(.accent)
                
                Text("Type the name you would like to be called.")
                    .foregroundStyle(.secondary)
                
            }
            .padding(.bottom)
            
            TextField("Your name", text: $name)
                .textFieldStyle(.roundedBorder)
                .focused($isFocused)
            
            Spacer()
            
            Button {
                createUser()
                
                if isOnboarding {
                    finishOnboarding()
                } else {
                    dismiss()
                }
            } label: {
                Text("Begin the journey")
                    .fontWeight(.semibold)
                    .frame(width: 250, height: 50)
                    .foregroundStyle(.white)
#if (os(iOS))
                    .background(.accent)
                    .clipShape(Capsule())
#endif
            }
            .disabled(name.isEmpty)
            .padding(.bottom, 40)
        }
        .padding()
        .onChange(of: currentTab) { oldValue, newValue in
            if newValue == 1 {
                isFocused = true
            } else {
                isFocused = false
            }
        }
    }
    
    func createUser() {
        let user = User(name: name, image: nil)
        context.insert(user)
    }
    
    func finishOnboarding() {
        isOnboarding = false
        context.insert(Day.init())
    }
}

