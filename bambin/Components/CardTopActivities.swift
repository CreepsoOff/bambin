//
//  CardTopActivities.swift
//  bambin
//
//  Created by Imane on 11/06/2026.


import SwiftUI


// COMPOSANT (VUE RÉUTILISABLE) CARTE TOP ACTIVITÉS
struct CardTopActivities: View {

    // Données injectées
    let activity: Activity
    let count: Int
    let topImage: String

    // Propriété calculée --> return color en fonction de la catégorie d'activité
    var cardBgColor: Color {
        switch activity.category {
        case .kitchen:
            return .yellow
        case .sport:
            return .red
        case .nature:
            return .green
        case .drawing:
            return .orange
        case .sciences:
            return .blue
        }
    }

    var body: some View {

        ZStack {
            
            // Style de la carte
            RoundedRectangle(cornerRadius: 7)
                .stroke(.white, lineWidth: 6)
                .background(cardBgColor)
                .frame(maxWidth: 370, maxHeight: 132)

            HStack {

                // image de l'activité
                Image(activity.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 73)
                    .rotationEffect(.degrees(10))

                Spacer()

                // image reward
                Image(topImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 74, height: 62)
                    .padding(.horizontal)
                    
            }
            .padding()

            VStack(spacing: 10) {

                // Badge catégorie de l'activité
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 97, height: 27)
                        .foregroundStyle(.white)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))

                        // affichage de la valeur de la catégorie de l'activité écrit en majuscule
                        Text(activity.category.rawValue.uppercased())
                            .font(.system(size: 10, weight: .black))
                            .lineLimit(1)
                    }
                    // style du badge
                    .foregroundStyle(cardBgColor)
                    .padding(.horizontal, 8)
                    .frame(height: 27)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.white)
                    )
                }

                HStack {
                    
                    // Nom de l'activité
                    Text(activity.actionText)
                    Text(activity.productName)
                }.font(.system(size: 16, weight: .semibold))

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)

                    // nbr de fois joué
                    Text("\(count) fois jouées")
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    
    // Instanciation de la vue
    CardTopActivities(
        
        // Objet activité complet de test
        activity: Activity(
            actionText: "Dessine un",
            productName: "OEUF",
            imageName: "egg",
            gallery: ["egg_gal1", "egg_gal2"],
            description: "Prépare une délicieuse pizza maison en famille : étale la pâte, ajoute la sauce tomate, le fromage puis les garnitures préférées. Une activité simple et gourmande pour apprendre à cuisiner, partager les tâches et savourer le résultat tous ensemble autour d'un repas convivial.",
            duration: 10,
            likes: 99,
            emplacements: [.home, .inside],
            category: .drawing,
            materialsNeeded: ["Feuilles de papier", "Feutres ou crayons"],
            numberOfParticipants: 1,
            difficulty: 1
        ),
        
        // stat + reward
        count: 6,
        topImage: "reward1"
    )
}
