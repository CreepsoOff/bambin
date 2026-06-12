import SwiftUI

struct DetailedUserView: View {
    
    @Binding var family: Family
    let userID: UUID
    
    @State private var isEditingUser = false
    
    private var user: User? {
        family.users.first { $0.id == userID }
    }
    
    private var favoriteActivities: [Activity] {
        guard let user else { return [] }
        
        return MockData.activities.filter { activity in
            user.favoriteActivities.contains(activity.id)
        }
    }
    
    var body: some View {
        Group {
            if let user {
                List {
                    Section {
                        VStack(spacing: 12) {
                            UserAvatar(user: user, size: 120)
                            
                            Text(user.name)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("\(user.age) ans")
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                    }
                    .listRowBackground(Color.clear)
                    
                    Section("Résumé") {
                        LabeledContent("Temps total", value: "\(user.totalTime) min")
                        LabeledContent("Activités réalisées", value: "\(user.activities.count)")
                        LabeledContent("Favoris", value: "\(user.favoriteActivities.count)")
                    }
                    
                    Section("Intérêts") {
                        if user.interests.isEmpty {
                            Text("Aucun intérêt renseigné")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(user.interests, id: \.self) { interet in
                                Text(interet.rawValue)
                            }
                        }
                    }
                    
                    Section("Activités réalisées") {
                        if user.activities.isEmpty {
                            Text("Aucune activité réalisée")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(user.activities) { activity in
                                NavigationLink {
                                    ActivityDetailView(activity: activity)
                                } label: {
                                    ActivitySummaryRow(activity: activity)
                                }
                            }
                        }
                    }
                    
                    Section("Favoris") {
                        if favoriteActivities.isEmpty {
                            Text("Aucun favori")
                                .foregroundStyle(.secondary)
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
                .navigationTitle(user.name)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Modifier") {
                            isEditingUser = true
                        }
                    }
                }
                .sheet(isPresented: $isEditingUser) {
                    NavigationStack {
                        EditUserView(user: user) { updatedUser in
                            updateUser(updatedUser)
                        }
                    }
                }
            } else {
                ContentUnavailableView(
                    "Membre introuvable",
                    systemImage: "person.crop.circle.badge.questionmark"
                )
            }
        }
    }
    
    private func updateUser(_ updatedUser: User) {
        if let index = family.users.firstIndex(where: { $0.id == updatedUser.id }) {
            family.users[index] = updatedUser
        }
    }
}

#Preview {
    
    @Previewable @State var family = MockData.family
    
    DetailedUserPreview()
}

private struct DetailedUserPreview: View {
    @State private var family = MockData.family
    
    var body: some View {
        NavigationStack {
            DetailedUserView(
                family: $family,
                userID: family.users[0].id
            )
        }
    }
}
