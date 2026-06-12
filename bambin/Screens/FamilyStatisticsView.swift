//
//  FamilyStatisticsView.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//


import SwiftUI

struct FamilyStatisticsView: View {
    
    let family: Family
    
    private var totalTime: Int {
        family.users.reduce(0) { total, user in
            total + user.totalTime
        }
    }
    
    private var totalCompletedActivities: Int {
        family.users.reduce(0) { total, user in
            total + user.activities.count
        }
    }
    
    private var totalFavorites: Int {
        Set(family.users.compactMap { $0.favoriteActivities }).count
    }
    
    var body: some View {
        List {
            Section("Résumé") {
                /// LabeledContent sert à un affichage tel des réglages
                LabeledContent("Membres", value: "\(family.users.count)")
                LabeledContent("Temps total", value: "\(totalTime) min")
                LabeledContent("Activités réalisées", value: "\(totalCompletedActivities)")
                LabeledContent("Favoris", value: "\(totalFavorites)")
            }
            
            Section("Intérêts de la famille") {
                ForEach(Interet.allCases, id: \.self) { interet in
                    let count = family.users.filter { user in
                        user.interests.contains(interet)
                    }.count
                    
                    HStack {
                        Text(interet.rawValue)
                        Spacer()
                        Text("\(count)")
                            .foregroundStyle(.secondary)
                    }
                }
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
        .navigationTitle("Les statistiques de la famille")
        .navigationSubtitle(family.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FamilyStatisticsView(family: MockData.family)
    }
}
