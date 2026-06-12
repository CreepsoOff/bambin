//
//  FamilySettingsView.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//


import SwiftUI

struct FamilySettingsView: View {
    
    @Binding var family: Family
    
    var body: some View {
        Form {
            Section("Famille") {
                TextField("Nom de la famille", text: $family.name)
                
                LabeledContent("Membres", value: "\(family.users.count)")
            }
            
            Section("Membres") {
                ForEach(family.users) { user in
                    NavigationLink {
                        EditUserView(
                            user: user,
                            showsCancelButton: false
                        ) { updatedUser in
                            if let index = family.users.firstIndex(where: { $0.id == updatedUser.id }) {
                                family.users[index] = updatedUser
                            }
                        }
                    } label: {
                        HStack {
                            UserAvatar(user: user, size: 64)
                            Text(user.name)
                        }
                    }
                }
            }
            .listRowInsets(.vertical, 8)
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
        .navigationTitle("Réglages")
        .navigationSubtitle(family.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var family = MockData.family
    
    NavigationStack {
        FamilySettingsView(family: $family)
    }
}
