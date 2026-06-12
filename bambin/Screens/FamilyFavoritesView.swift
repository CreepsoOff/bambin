//
//  FamilyFavoritesView.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//


import SwiftUI

struct FamilyFavoritesView: View {
    
    let family: Family
    
    private var favoriteActivities: [Activity] {
        let favoriteIDs = Set(family.users.flatMap { $0.favoriteActivities })
        
        return MockData.activities.filter { activity in
            favoriteIDs.contains(activity.id)
        }
    }
    
    var body: some View {
        List {
            if favoriteActivities.isEmpty {
                ContentUnavailableView(
                    "Aucun favori",
                    systemImage: "star",
                    description: Text("Les activités favorites de la famille apparaîtront ici !")
                )
            } else {
                ForEach(favoriteActivities) { activity in
                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
                        ActivitySummaryRow(activity: activity)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
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
        .navigationTitle("Les activités favorites de la famille")
        .navigationSubtitle(family.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview(traits: .bambin) {
    NavigationStack {
        FamilyFavoritesView(family: MockData.family)
    }
}
