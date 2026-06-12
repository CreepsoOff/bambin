//
//  FamilyView.swift
//  bambin
//
//  Created by Apprenant154 on 09/06/2026.
//

import SwiftUI

struct FamilyView: View {
    
    
    @State private var family: Family = MockData.family
    @State private var isModifying = false
    @State private var isSelectionMode = false
    @State private var selectedUserIDs: Set<UUID> = []
    @State private var newFamilyName = ""
    @State private var isCreatingNew = false
    
    @State private var editMode: EditMode = .inactive
    
    private var isEditing: Bool {
        editMode == .active
    }
    
    private var areAllUsersSelected: Bool {
        !family.users.isEmpty && selectedUserIDs.count == family.users.count
    }
    
    private var avatarSpacing: CGFloat {
//        let baseOffset = -88.0
//        let userMultiplier = 9.5 * Double(family.users.count)
//        return CGFloat(baseOffset - userMultiplier)
        
        return CGFloat(-130)
    }
    
    var body: some View {
        List(selection: $selectedUserIDs) {
            
            // MARK: Liste des icônes de la famille (en haut)
            Section {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: avatarSpacing) {
                        Spacer()
                        ForEach(family.users.reversed()) { user in
                            UserAvatar(user: user)
                        }
                        Spacer()
                    }
                    
                    // MARK: Texte du nom de la famille
                    HStack(alignment: .center) {
                        Spacer()
                        HStack(spacing: 8) {
                            Text(family.name)
                                .font(.largeTitle)
                                .bold()
                            Button {
                                newFamilyName = family.name
                                isModifying = true
                            } label: {
                                Image(systemName: "pencil")
                                    .font(.body)
                                    .foregroundStyle(.black)
                                    .padding(6)
                                    .glassEffect(.regular.tint(.lavender).interactive(), in: .circle)
                            }
                            .buttonStyle(.plain)
                            .alert("Modifier le nom", isPresented: $isModifying) {
                                TextField("Nom de la famille", text: $newFamilyName)
                                    .font(.system(.body, design: .rounded))
                                
                                let cleanedName = newFamilyName.trimmingCharacters(in: .whitespaces)
                                Button("Valider", role: .confirm) {
                                    family.name = newFamilyName
                                }
                                .disabled(cleanedName.isEmpty)
                                
                                Button("Annuler", role: .cancel) {}
                            } message: {
                                Text("Entrez le nouveau nom pour votre famille.")
                            }
                            
                        }
                        Spacer()
                    }
                    .padding(.top, 3)
                }
                .padding(.vertical, 8)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            // MARK: Liste de la famille
            Section {
                ForEach(family.users) { user in
                    NavigationLink {
                        DetailedUserView(user: user)
                    } label: {
                        FamilyUserRow(user: user)
                    }
                    .tag(user.id)
                }
                
                Button {
                        isCreatingNew = true
                } label: {
                    Text("Ajouter un nouveau membre")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowSeparator(.visible, edges: .top)
            }
            .listRowInsets(.vertical, 8)
            .listRowSeparator(.hidden, edges: .top)
            
            Section {
                Label("Mes favoris", systemImage: "star.fill")
                    .foregroundStyle(.yellow)
                Label("Mes statistiques", systemImage: "chart.pie.fill")
                    .foregroundStyle(.blue)
                Label("Mes activités", systemImage: "apps.iphone")
                    .foregroundStyle(.purple)
                    .listRowSeparator(.visible)
                
                Label("Réglages", systemImage: "gearshape.fill")
                    .foregroundStyle(.gray)
            }
            .listRowSeparator(.hidden)
            .listRowBackground(Color.white)
        }
        .environment(\.editMode, $editMode)
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .navigationTitle(family.name)
        .toolbarTitleDisplayMode(.large)
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
        .toolbar {
            ToolbarItem(placement: .largeTitle) {
                Text("")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        if isEditing {
                            selectedUserIDs.removeAll()
                            editMode = .inactive
                        } else {
                            editMode = .active
                        }
                    }
                } label: {
                    Text(isEditing ? "Annuler" : "Sélect.")
                }
            }
            
            if isEditing {
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        if areAllUsersSelected {
                            selectedUserIDs.removeAll()
                        } else {
                            selectedUserIDs = Set(family.users.compactMap(\.self.id))
                        }
                    } label: {
                        Text(areAllUsersSelected ? "Tout désélectionner" : "Tout sélectionner")
                            .font(.body)
                            .bold()
                            .foregroundStyle(.black)
                    }
                    .disabled(family.users.count <= 0)
                    .opacity(family.users.count <= 0 ? 0.4 : 1)
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        withAnimation {
                            family.users.removeAll { user in
                                selectedUserIDs.contains(user.id)
                            }
                            
                            selectedUserIDs.removeAll()
                            editMode = .inactive
                        }
                    } label: {
                        Text("Supprimer")
                            .font(.body)
                            .bold()
                            .foregroundStyle(.red)
                    }
                    .disabled(selectedUserIDs.isEmpty || family.users.count == 1)
                    .opacity(selectedUserIDs.isEmpty || family.users.count == 1 ? 0.4 : 1)
                }
            }
        }
        .toolbarVisibility(isEditing ? .visible : .hidden, for: .bottomBar)
        .toolbarVisibility(isEditing ? .hidden : .visible, for: .tabBar)
        .sheet(isPresented: $isCreatingNew) {
            AddUserView(familyUsers: $family.users)
        }
        
    }
}

#Preview {
    NavigationStack {
        FamilyView()
    }
}
