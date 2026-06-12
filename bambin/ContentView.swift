//
//  ContentView.swift
//  bambin
//
//  Created by Apprenant154 on 05/06/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        TabView {

            Tab("Activités", systemImage: "books.vertical") {
                NavigationStack {
                    ActivityView(search: $searchText)
                }
            }

            Tab("Stats", systemImage: "chart.line.text.clipboard") {
            }
            Tab("Infos", systemImage: "info.bubble") {
            }
            Tab("Famille", systemImage: "person.3") {
            }
            Tab("Search", systemImage: "magnifyingglass", role: .search) {
                NavigationStack {
                    ActivityView(search: $searchText)
                }
                .searchable(
                    text: $searchText,
                    placement: .automatic,
                    prompt: "Rechercher une activité"
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
