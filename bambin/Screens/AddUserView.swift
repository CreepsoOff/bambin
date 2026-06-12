//
//  AddUserView.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//

import PhotosUI
import SwiftUI

/*

 struct User: Identifiable, Hashable, Codable {
 var id = UUID()
 var name: String
 var age: Int
 var avatarName: String
 var totalTime: Int
 var activities: [Activity]
 var interests: [Interet]
 var favoriteActivities: [UUID] = []
 }

 */

struct AddUserView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var age: Int? = nil
    @State private var interets: Set<Interet> = []
    @State private var avatarImageData: Data?

    @State private var avatarAssetName: String = ""

    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: Image?

    @State private var showInteretsSheet: Bool = false

    @Binding var familyUsers: [User]
    
    private var cleanedAvatarAssetName: String {
        avatarAssetName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                // MARK: Section personne
                Section("Personne") {
                    TextField("Prénom", text: $name)
                    TextField("Âge", value: $age, format: .number)
                        .keyboardType(.numberPad)
                }

                // MARK: Section avatar
                Section("Avatar") {
                    avatarPreview
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity)

                    TextField("Nom de l’asset", text: $avatarAssetName)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()

                    PhotosPicker(
                        selection: $avatarItem,
                        matching: .images
                    ) {
                        Label("Choisir une image", systemImage: "photo")
                    }

                    if avatarImage != nil {
                        Button("Revenir à l’asset") {
                            avatarImage = nil
                            avatarImageData = nil
                            avatarItem = nil
                        }
                    }
                }
                .onChange(of: avatarAssetName) {
                    avatarImage = nil
                    avatarImageData = nil
                    avatarItem = nil
                }
                .onChange(of: avatarItem) {
                    Task {
                        avatarImage = try? await avatarItem?.loadTransferable(type: Image.self)
                        avatarImageData = try? await avatarItem?.loadTransferable(type: Data.self)
                    }
                }
                // MARK: FIN Section avatar

                // MARK: Activités
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
            .sheet(isPresented: $showInteretsSheet) {
                NavigationStack {
                    List {
                        ForEach(Interet.allCases, id: \.self) { interet in
                            Button {
                                if interets.contains(interet) {
                                    interets.remove(interet)
                                } else {
                                    interets.insert(interet)
                                }
                            } label: {
                                HStack {
                                    Text(interet.rawValue)
                                        .foregroundStyle(.primary)

                                    Spacer()

                                    if interets.contains(interet) {
                                        Image(
                                            systemName: "checkmark.circle.fill"
                                        )
                                        .foregroundStyle(
                                            Color.accentColor.secondary
                                        )
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
            .navigationTitle("Nouveau membre")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Annuler")
                    }

                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        let newUser = User(
                            name: name,
                            age: age ?? 0,
                            avatarName: cleanedAvatarAssetName,
                            avatarImageData: avatarImageData,
                            totalTime: 0,
                            activities: [],
                            interests: Array(interets)
                        )
                        familyUsers.append(newUser)
                        dismiss()
                    } label: {
                        Text("Valider")
                    }
                    .disabled(name.isEmpty)
                }
                

            }
        }

    }

    private var avatarPreview: some View {
        Group {
            if let avatarImage {
                avatarImage
                    .resizable()
                    .scaledToFill()
            } else if let uiImage = UIImage(named: cleanedAvatarAssetName) {
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
        if interets.isEmpty {
            return "Aucun"
        } else if interets.count == 1 {
            return interets.first!.rawValue
        } else {
            return "\(interets.count) sélectionnés"
        }
    }
}

#Preview {
    AddUserView(familyUsers: .constant(MockData.family.users))
}
