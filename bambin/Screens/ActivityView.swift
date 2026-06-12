//
//  ActivityView.swift
//  bambin
//
//  Created by apprenant130 on 10/06/2026.
//

import SwiftUI

struct ActivityView: View {

    @State private var activities: [Activity] = MockData.activities
    @Binding var search: String

    var counter: Int = 1

    // Create array of all family members interests
    // Use of Set to remove duplicates
    let familyInterests: Set<Interet> = Set(
        MockData.familyUsers.flatMap { $0.interests }
    )

    // Filter with the category picker
    var filteredActivitiesPicker: [Activity] {

        switch selectedFilter {

        case "Pour vous":
            activities.filter { familyInterests.contains($0.category) }

        case "Tendance":
            activities.filter { $0.likes > 100 && $0.difficulty >= 2 }

        case "Coup de ❤️":
            activities.sorted { $0.likes > $1.likes }

        case "Tous":
            activities

        default:
            activities
        }
    }

    // Filter with the search
    var filteredActivities: [Activity] {
        filteredActivitiesPicker
            .filter {
                search.isEmpty
                    || $0.productName.lowercased().contains(
                        search.lowercased()
                    )
            }
    }

    @State private var selectedFilter: String = "Pour vous"
    let searchFilters: [String] = [
        "Pour vous", "Tendance", "Coup de ❤️", "Tous",
    ]

    let columns: [GridItem] = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            //            Text("Bambin")
            //                .font(.largeTitle)
            //                .bold()

            Picker("Search filter", selection: $selectedFilter) {
                ForEach(searchFilters, id: \.self) { searchFilter in
                    Text(searchFilter)
                }
            }
            .pickerStyle(.segmented)
            .padding([.top, .horizontal])

            LazyVGrid(columns: columns, spacing: 25) {

                ForEach(filteredActivities) { activity in

                    NavigationLink {
                        ActivityDetailView(activity: activity)
                    } label: {
                        ActivityCardView(activity: activity)
                    }

                    .buttonStyle(AnimatedButtonStyle())

                    //                        .overlay {
                    //                            GeometryReader { proxy in
                    //                                Text(
                    //                                    "\(Int(proxy.size.width)) x \(Int(proxy.size.height))"
                    //                                )
                    //                                .font(.caption)
                    //                                .foregroundStyle(.white)
                    //                                .padding(4)
                    //                                .background(.purple)
                    //                                .fixedSize()
                    //                                .frame(
                    //                                    width: proxy.size.width,
                    //                                    height: proxy.size.height
                    //                                )
                    //                            }
                    //                        }

                }

            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color.gray.opacity(0.2))
        .navigationTitle("Liste d'activités")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ActivityCardView: View {

    @State private var isActivityLiked: Bool = false

    var activity: Activity

    var cardBgColor: Color {
        switch activity.category {
        case .kitchen:
            Color.yellow
        case .sport:
            Color.red
        case .nature:
            Color.green
        case .drawing:
            Color.orange
        case .sciences:
            Color.blue
        }
    }

    var body: some View {

        ZStack {
            VStack(alignment: .leading) {

                // Time and Like button
                HStack {

                    Text(String(activity.duration))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .foregroundStyle(.white)
                        .bold()
                        .background(
                            Color(.black.opacity(0.65))
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )
                        .shadow(radius: 4, y: 6)

                    Spacer()

                    Button {
                        print("Tapped heart.")
                        isActivityLiked.toggle()
                    } label: {
                        HStack {
                            Image(
                                systemName: isActivityLiked
                                    ? "heart.fill" : "heart"
                            )
                            .foregroundStyle(isActivityLiked ? .red : .white)
                            Text(
                                String(
                                    isActivityLiked
                                        ? activity.likes + 1 : activity.likes
                                )
                            )
                            .foregroundStyle(.white)
                        }
                        .font(.callout)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            Color(.black.opacity(0.65))
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )
                        .shadow(radius: 4, y: 6)
                    }
                }

                // Subject sentence
                HStack {

                    // Activity name
                    VStack(alignment: .leading) {
                        Text(activity.actionText)
                            .font(.title)

                        Text(activity.productName.uppercased())
                            .font(.largeTitle)
                            .bold()
                    }

                    Spacer()

                    // Activity Image
                    Image(activity.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 128)
                        .offset(x: 10, y: 20)
                        .scaleEffect(1.5)
                        .rotationEffect(.degrees(5))
                }
            }
            //            .background(Color.blue.opacity(0.5))

        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
        .background(
            Color(cardBgColor)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 25)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(.white, lineWidth: 8)
        )
    }
}

struct AnimatedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.linear(duration: 0.1), value: configuration.isPressed)
    }
}

struct ActivityDetailView: View {

    let activity: Activity

    @State private var isMaterialsVisible: Bool = false

    @State private var isFavorite: Bool = false
    @State private var isLater: Bool = false
    @State private var isDone: Bool = false

    var cardBgColor: Color {
        switch activity.category {
        case .kitchen:
            Color.yellow
        case .sport:
            Color.red
        case .nature:
            Color.green
        case .drawing:
            Color.orange
        case .sciences:
            Color.blue
        }
    }

    var activityLevel: String {
        switch activity.difficulty {
        case 1:
            "Facile"
        case 2:
            "Intermédiaire"
        case 3:
            "Difficile"
        default:
            "Normal"
        }
    }

    var body: some View {

        ScrollView {
            VStack(alignment: .leading, spacing: 30) {

                // Presentation image
                ZStack {
                    Image(activity.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()

                    Text(activity.category.rawValue)
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Color.white
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomLeading
                        )
                        .padding(5)
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .background(
                    cardBgColor
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )
                .shadow(radius: 5, y: 6)

                // Title and description
                Text("\(activity.actionText) \(activity.productName)")
                    .font(.title)
                    .bold()
                Text(activity.description)

                // More informations
                VStack(spacing: 20) {
                    HStack {
                        Label {
                            Text("Matériel nécessaire")

                        } icon: {
                            Image(systemName: "shippingbox.fill")
                                .foregroundColor(.orange)
                                .font(.title3)
                        }

                        Spacer()

                        Button(
                            "Voir",
                            systemImage: "chevron.right",
                            action: {
                                isMaterialsVisible.toggle()
                            }
                        )
                        .labelStyle(.iconOnly)
                    }
                    Divider()
                    HStack {
                        Label {
                            Text("Nombre de personne")

                        } icon: {
                            Image(systemName: "person.2.fill")
                                .foregroundColor(.red)
                                .font(.title3)
                        }
                        Spacer()
                        Text("\(activity.numberOfParticipants)")
                    }
                    Divider()
                    HStack {
                        Label {
                            Text("Niveau de difficulté")

                        } icon: {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.green)
                                .font(.title3)
                        }
                        Spacer()
                        Text(activityLevel)
                    }
                    Divider()
                    HStack {
                        Label {
                            Text("Durée estimée")

                        } icon: {
                            Image(systemName: "timer")
                                .foregroundColor(.blue)
                                .font(.title3)
                        }
                        Spacer()
                        Text("\(activity.duration) minutes")
                    }
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .background(
                    Color.white
                )
                .clipShape(RoundedRectangle(cornerRadius: 25))

                Button(
                    "Valider l'activité",
                    systemImage: "checkmark.circle.fill"
                ) {
                    isDone.toggle()
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.glassProminent)
                .controlSize(.large)

            }
            .padding()
        }
        .background(Color.gray.opacity(0.2))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: "heart.fill")
                }
                .tint(isFavorite ? .red : .gray)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isLater.toggle()
                } label: {
                    Image(systemName: "clock.fill")
                }
                .tint(isLater ? .orange : .gray)
            }
        }
        .sheet(isPresented: $isMaterialsVisible) {
            NavigationStack {
                List {
                    ForEach(activity.materialsNeeded.indices, id: \.self) {
                        index in
                        Label(
                            activity.materialsNeeded[index],
                            systemImage: "\(index + 1).circle"
                        )
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isDone) {
            VStack(spacing: 20) {
                Image(activity.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(50)

                Text("Bravo !")
                    .font(.title)
                Text("Vous avez terminé l'activité!")
                    .font(.title2)
            }
            .presentationDetents([.large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview(traits: .bambin) {

    @Previewable @State var searchText: String = ""

    TabView {

        Tab("Activités", systemImage: "books.vertical") {
            NavigationStack {
                ActivityView(search: $searchText)
            }
        }

        Tab("Stats", systemImage: "chart.line.text.clipboard") {
        }
        Tab("Infos", systemImage: "info.bubble") {
        }
        Tab("Famille", systemImage: "person.3") {
        }
        Tab("Search", systemImage: "magnifyingglass", role: .search) {
            NavigationStack {
                ActivityView(search: $searchText)
            }
            .searchable(
                text: $searchText,
                placement: .automatic,
                prompt: "Rechercher une activité"
            )
        }
    }
}

#Preview(traits: .bambin) {
    ZStack {
        Color.red.opacity(0.2).ignoresSafeArea()
        ActivityCardView(activity: MockData.activities[0])
    }
}

#Preview(traits: .bambin) {
    NavigationStack {
        ActivityDetailView(activity: MockData.activities[0])
    }
}
