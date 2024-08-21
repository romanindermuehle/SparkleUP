//
//  ContentView.swift
//  SparkleUP
//
//  Created by Roman Indermühle on 17.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var selection: AppScreen? = .today
    var body: some View {
        AppTabView(selection: $selection)
    }
}

#Preview {
    ContentView()
}
