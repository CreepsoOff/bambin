    //
    //  EditUserView.swift
    //  bambin
    //
    //  Created by Apprenant154 on 12/06/2026.
    //

import PhotosUI
import SwiftUI
import UIKit

struct EditUserView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let user: User
    var showsCancelButton: Bool = true
    let onSave: (User) -> Void
    
    @State private var draftUser = User(
        name: "",
        age: 0,
        avatarName: "",
        avatarImageData: nil,
        totalTime: 0,
        activities: [],
        interests: []
    )
    
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?
    @State private var showInteretsSheet = false
    @State private var hasLoadedUser = false
    
    private var cleanedName: String {
        draftUser.name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var cleanedAvatarAssetName: String {
        draftUser.avatarName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private var canValidate: Bool {
        !cleanedName.isEmpty
        && draftUser.age > 0
        && (!cleanedAvatarAssetName.isEmpty || draftUser.avatarImageData != nil)
    }
    
    var body: some View {
        Form {
            Section("Personne") {
                TextField("Prénom", text: $draftUser.name)
                
                TextField("Âge", value: $draftUser.age, format: .number)
                    .keyboardType(.numberPad)
            }
            
            Section("Avatar") {
                avatarPreview
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity)
                
                TextField("Nom de l’asset", text: $draftUser.avatarName)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                PhotosPicker(
                    selection: $avatarItem,
                    matching: .images
                ) {
                    Label("Choisir une image", systemImage: "photo")
                }
                
                if draftUser.avatarImageData != nil || avatarImage != nil {
                    Button("Revenir à l’asset") {
                        avatarImage = nil
                        draftUser.avatarImageData = nil
                        avatarItem = nil
                    }
                }
            }
            .onChange(of: avatarItem) {
                Task {
                    avatarImage = try? await avatarItem?.loadTransferable(type: Image.self)
                    draftUser.avatarImageData = try? await avatarItem?.loadTransferable(type: Data.self)
                }
            }
            
            Section("Activités") {
                Button {
                    showInteretsSheet = true
                } label: {
                    HStack {
                        Text("Intérêts")
                            .foregroundStyle(.primary)
                        
                        Spacer()
                        
                        Text(interetsSummary)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
        }
        .onAppear {
            if !hasLoadedUser {
                draftUser = user
                hasLoadedUser = true
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
        .navigationTitle("Modifier le membre")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if showsCancelButton {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Valider") {
                    saveUser()
                }
                .disabled(!canValidate)
            }
        }
        .sheet(isPresented: $showInteretsSheet) {
            NavigationStack {
                List {
                    ForEach(Interet.allCases, id: \.self) { interet in
                        Button {
                            toggleInteret(interet)
                        } label: {
                            HStack {
                                Text(interet.rawValue)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                if draftUser.interests.contains(interet) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(Color.accentColor)
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Intérêts")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Terminer") {
                            showInteretsSheet = false
                        }
                    }
                }
            }
            .presentationDetents([.medium])
        }
    }
    
    private var avatarPreview: some View {
        Group {
            if let avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFill()
            } else if let avatarImageData = draftUser.avatarImageData,
                      let uiImage = UIImage(data: avatarImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if !cleanedAvatarAssetName.isEmpty,
                      let uiImage = UIImage(named: cleanedAvatarAssetName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.badge.questionmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.gray)
                    .scaleEffect(0.75)
            }
        }
        .clipShape(Circle())
    }
    
    private var interetsSummary: String {
        if draftUser.interests.isEmpty {
            return "Aucun"
        } else if draftUser.interests.count == 1 {
            return draftUser.interests.first?.rawValue ?? "Aucun"
        } else {
            return "\(draftUser.interests.count) sélectionnés"
        }
    }
    
    private func toggleInteret(_ interet: Interet) {
        if draftUser.interests.contains(interet) {
            draftUser.interests.removeAll { $0 == interet }
        } else {
            draftUser.interests.append(interet)
        }
    }
    
    private func saveUser() {
        var updatedUser = draftUser
        
        updatedUser.name = cleanedName
        updatedUser.avatarName = cleanedAvatarAssetName
        
        onSave(updatedUser)
        dismiss()
    }
}

#Preview {
    @Previewable @State var family = MockData.family
    
    NavigationStack {
        EditUserView(user: family.users[0]) { updatedUser in
            if let index = family.users.firstIndex(where: { $0.id == updatedUser.id }) {
                family.users[index] = updatedUser
            }
        }
    }
}
