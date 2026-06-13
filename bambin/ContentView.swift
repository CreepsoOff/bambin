//
//  ContentView.swift
//  bambin
//
//  Created by Apprenant154 on 05/06/2026.
//

import SwiftUI

struct ContentView: View {

    @State private var searchText: String = ""
    @State private var showOnboarding: Bool = true

    var body: some View {

        if showOnboarding {

            OnBoarding {
                showOnboarding = false
            }

        } else {

            TabView {

                Tab("Activités", systemImage: "books.vertical") {
                    NavigationStack {
                        ActivityView(search: $searchText)
                    }
                }

                Tab("Stats", systemImage: "chart.line.text.clipboard") {
                    NavigationStack {
                        StatisticsView(
                            user: MockData.familyUsers[0],
                            activities: MockData.activities,
                            userLogs: MockData.userLogs
                        )
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
                    NavigationStack {
                        ActivityView(search: $searchText)
                    }
                    .searchable(
                        text: $searchText,
                        prompt: "Rechercher une activité"
                    )
                }
            }
        }
    }
}

#Preview(traits: .bambin) {
    ContentView()
}
