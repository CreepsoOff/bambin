//
//  ActivityView.swift
//  bambin
//
//  Created by apprenant130 on 10/06/2026.
//

import SwiftUI

struct ActivityView: View {

    @State private var activities: [Activity] = MockData.activities

    var counter: Int = 1

    var filteredActivities: [Activity] {

        switch selectedFilter {
        case "Pour vous":
            activities
        // Union tous les tableaux d'interets de la famille
        // Prendre les deux premriers les plus aimer
        // Filtrer les résultats avec les 2 premiers

        case "Tendance":
            activities.filter { $0.likes > 100 && $0.difficulty >= 2 }

        case "Coup de ❤️":
            activities.sorted { activityA, activityB in
                activityA.likes > activityB.likes
            }

        case "Tous":
            activities

        default:
            activities
        }
    }

    @State private var selectedFilter: String = "Pour vous"
    let searchFilters: [String] = [
        "Pour vous", "Tendance", "Coup de ❤️", "Tous",
    ]

    let columns: [GridItem] = [
        //        GridItem(.adaptive(minimum: 100, maximum: 110)),
        //        GridItem(.adaptive(minimum: 100, maximum: 110)),
        GridItem(.flexible())
        //        GridItem(.flexible()),
        //        GridItem(.flexible(), spacing: 20),
        //        GridItem(.flexible(), spacing: 20),
    ]

    var body: some View {
        ScrollView {
            Text("Bambin")
                .font(.largeTitle)
                .bold()

            Picker("Search filter", selection: $selectedFilter) {
                ForEach(searchFilters, id: \.self) { searchFilter in
                    Text(searchFilter)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

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

                        Text(activity.productName)
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
    }
}

#Preview(traits: .bambin) {
    TabView {

        Tab("Activités", systemImage: "books.vertical") {
            NavigationStack {
                ActivityView()
            }
        }

        Tab("Stats", systemImage: "chart.line.text.clipboard") {
        }
        Tab("Infos", systemImage: "info.bubble") {
        }
        Tab("Famille", systemImage: "person.3") {
        }
        Tab("Famille", systemImage: "magnifyingglass", role: .search) {

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
