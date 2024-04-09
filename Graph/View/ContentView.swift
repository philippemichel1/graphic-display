//
//  ContentView.swift
//  Graph
//
//  Created by Philippe MICHEL on 09/04/2024.
//

import SwiftUI
import Charts

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            
        }
        .onAppear() {
            Task {
                
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
