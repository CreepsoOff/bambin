//
//  FamilyActivitiesView.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//


import SwiftUI

struct FamilyActivitiesView: View {
    
    let family: Family
    
    private var hasActivities: Bool {
        family.users.contains { !$0.activities.isEmpty }
    }
    
    var body: some View {
        List {
            if !hasActivities {
                ContentUnavailableView(
                    "Aucune activité",
                    systemImage: "apps.iphone",
                    description: Text("Les activités réalisées par les membres apparaîtront ici.")
                )
            } else {
                ForEach(family.users) { user in
                    if !user.activities.isEmpty {
                        Section(user.name) {
                            ForEach(user.activities) { activity in
                                NavigationLink {
                                    ActivityDetailView(activity: activity)
                                } label: {
                                    ActivitySummaryRow(activity: activity)
                                }
                            }
                        }
                    }
                }
                .listRowBackground(Color.white)
            }
        }
        .background {
            ZStack {
                Color.lavender
                Image("backgroundPattern")
                    .resizable(resizingMode: .tile)
                    .blendMode(.multiply)
                    .opacity(0.4)
            }
            .ignoresSafeArea()
        }
        .scrollContentBackground(.hidden)
        .navigationTitle("Toutes les activités de la famille")
        .navigationSubtitle(family.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .bambin) {
    NavigationStack {
        FamilyActivitiesView(family: MockData.family)
    }
}
