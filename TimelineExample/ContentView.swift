//
//  ContentView.swift
//  TimelineExample
//
//  Created by Timothy on 18/03/2025.
//

import SwiftUI

struct ContentView: View {
    @State var expanded  = true
    var body: some View {
        ScrollView {
            HomeBuyingSection(applicationDetailsExpanded: $expanded)
        }
    }
}

#Preview {
    ContentView()
}
