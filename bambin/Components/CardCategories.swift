//
//  CardCategories.swift
//  bambin
//
//  Created by Apprenant131 on 12/06/2026.
//

import SwiftUI


// COMPOSANT (VUE RÉUTILISABLE) CARTE / CATEGORIES
struct CardCategories: View {

    // propriétés de la vue
    let backgroundColor: Color
    let title: String
    let categorie1: String
    let categorie2: String
    let categorie3: String
    let categorie4: String

    var body: some View {

        ZStack {

            VStack {

                // Style de la carte
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.white, lineWidth: 6)
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .background(backgroundColor)
                    .overlay {

                        VStack {

                            // Titre
                            HStack {

                                Text(title)
                                    .font(.headline)
                                    .bold()
                                    .padding(.top, 20)
                                    .padding(.leading, 16)

                                Spacer()

                            }

                            // Jeux - Manuel
                            HStack {

                                Text(categorie1)

                                Text("30 %")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.orange)

                                Spacer()

                                Text(categorie2)
                                Text("30 %")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.cyan)

                            }.padding()
                                .foregroundStyle(.primary)

                            // Physique - Nature
                            HStack {

                                Text(categorie3)
                                Text("20 %")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.red)

                                Spacer()

                                Text(categorie4)
                                Text("20 %")
                                    .font(.headline)
                                    .bold()
                                    .foregroundStyle(.green)

                            }.padding()
                                .foregroundStyle(.primary)

                        }

                    }
            }

        }
    }

}

#Preview {
    CardCategories(
        backgroundColor: .backgroundCardCategories,
        title: "Par catégories",
        categorie1: "Jeux",
        categorie2: "Manuel",
        categorie3: "Physique",
        categorie4: "Nature"
    )
}
