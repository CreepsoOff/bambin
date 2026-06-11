//
//  ContentView.swift
//  bambin
//
//  Created by Apprenant154 on 05/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            Tab("Activités", systemImage: "books.vertical") {
                NavigationStack {
                    ActivityView()
                }
            }

            Tab("Stats", systemImage: "chart.line.text.clipboard") {
            }
            Tab("Infos", systemImage: "info.bubble") {
            }
            Tab("Famille", systemImage: "person.3") {
            }
            Tab("Famille", systemImage: "magnifyingglass", role: .search) {

            }
        }
    }
}

#Preview {
    ContentView()
}
