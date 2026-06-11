//
//  FamilyView.swift
//  bambin
//
//  Created by Apprenant154 on 09/06/2026.
//

import SwiftUI

struct FamilyView: View {

    var family: Family = MockData.family

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack(spacing: CGFloat(-88 - (9.5 * Double(family.users.count)))) {
                    Spacer()
                    ForEach(family.users.reversed()) { user in
                        UserAvatar(user: user)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(family.name)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                Color.clear.frame(height: 1000)
            }
            .navigationTitle("Ma Famille")
            .toolbarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .largeTitle) {
                    Text("")
                }
            }
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
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
    }
}

#Preview(traits: .bambin) {
    NavigationStack {
        FamilyView()
    }
}
