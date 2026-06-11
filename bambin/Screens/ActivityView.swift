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

                    Button {

                        print(
                            "Tapped",
                            activity.actionText,
                            activity.productName
                        )
                        
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
