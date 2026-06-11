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
                NavigationStack {
                    StatisticsView()
                }
            }
            Tab("Infos", systemImage: "info.bubble") {
            }
            Tab("Famille", systemImage: "person.3") {
                NavigationStack {
                    FamilyView()
                }
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {

            }
        }
    }
}

#Preview {
    ContentView()
}
