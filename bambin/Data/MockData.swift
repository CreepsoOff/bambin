//
//  MockData.swift
//  bambin
//
//  Created by Apprenant154 on 09/06/2026.
//

import Foundation

struct MockData {
    
    static let activities: [Activity] = [
        Activity(
            actionText: "Cuisine une",
            productName: "pizza",
            imageName: "pizza",
            gallery: ["pizza_gal1", "pizza_gal2"],
            description: "Prépare une délicieuse pizza maison en famille : étale la pâte, ajoute la sauce tomate, le fromage puis les garnitures préférées. Une activité simple et gourmande pour apprendre à cuisiner, partager les tâches et savourer le résultat tous ensemble autour d'un repas convivial.",
            duration: 16,
            likes: 234,
            emplacements: [.home, .inside],
            category: .kitchen,
            materialsNeeded: ["Pâte à pizza", "Sauce tomate", "Fromage", "Garniture"],
            numberOfParticipants: 3,
            difficulty: 1
        ),
        Activity(
            actionText: "Joue au",
            productName: "basket",
            imageName: "basketball",
            gallery: ["basket_gal1"],
            description: "Sors le ballon et organise un petit match de basket, seul ou avec des amis. Dribble, vise le panier, invente des défis et améliore ton adresse tout en bougeant. Cette activité sportive développe la coordination, l'esprit d'équipe et donne envie de se dépenser avec plaisir.",
            duration: 60,
            likes: 159,
            emplacements: [.outside, .park, .indoorPlayground],
            category: .sport,
            materialsNeeded: ["Ballon de basket", "Panier"],
            numberOfParticipants: 2,
            difficulty: 2
        ),
        Activity(
            actionText: "Dessine un",
            productName: "oeuf",
            imageName: "egg",
            gallery: ["egg_gal1", "egg_gal2"],
            description: "Dessine un œuf rigolo, décoré ou transformé en personnage amusant. Choisis tes couleurs, ajoute des motifs, des yeux, un chapeau ou un décor autour de lui. Une activité calme et créative pour exercer son imagination, sa précision et repartir avec une jolie illustration.",
            duration: 10,
            likes: 99,
            emplacements: [.home, .inside],
            category: .drawing,
            materialsNeeded: ["Feuilles de papier", "Feutres ou crayons"],
            numberOfParticipants: 1,
            difficulty: 1
        ),
        Activity(
            actionText: "Balade-toi en",
            productName: "forêt",
            imageName: "tree",
            gallery: ["forest_gal1", "forest_gal2", "forest_gal3"],
            description: "Pars te promener en forêt pour respirer, écouter les oiseaux et observer les arbres, les feuilles et les petits trésors de la nature. Cette balade douce permet de se détendre, de discuter, de bouger et de découvrir l'environnement en prenant le temps de regarder autour de soi.",
            duration: 45,
            likes: 359,
            emplacements: [.forest, .outside],
            category: .nature,
            materialsNeeded: ["Bonnes chaussures", "Bouteille d'eau"],
            numberOfParticipants: 4,
            difficulty: 1
        ),
        Activity(
            actionText: "Observe les",
            productName: "papillons",
            imageName: "butterflies",
            gallery: ["butterfly_gal1"],
            description: "Installe-toi dans un jardin, un parc ou un coin fleuri pour observer les papillons. Regarde leurs couleurs, leurs formes et leurs mouvements, puis note ou dessine ce que tu vois. Une activité paisible pour apprendre la patience, l'observation et le respect des petites créatures.",
            duration: 30,
            likes: 109,
            emplacements: [.garden, .park, .countryside],
            category: .nature,
            materialsNeeded: ["Carnet d'observation", "Patience"],
            numberOfParticipants: 2,
            difficulty: 1
        ),
        Activity(
            actionText: "Cuisine un",
            productName: "burger",
            imageName: "hamburger",
            gallery: ["burger_gal1", "burger_gal2"],
            description: "Prépare un burger maison en choisissant les ingrédients préférés de chacun : pain, steak, salade, tomate, fromage et sauce. Les enfants peuvent assembler leur burger et comparer les créations. Une activité gourmande qui encourage l'autonomie, le partage et la découverte des goûts.",
            duration: 15,
            likes: 293,
            emplacements: [.home, .inside],
            category: .kitchen,
            materialsNeeded: ["Pains à burger", "Steaks", "Salade", "Tomates", "Sauce"],
            numberOfParticipants: 4,
            difficulty: 2
        ),
        Activity(
            actionText: "Organise une",
            productName: "soirée",
            imageName: "popcorn",
            gallery: ["popcorn_gal1"],
            description: "Organise une soirée cinéma chaleureuse à la maison avec du pop-corn, des plaids et un bon film. Prépare l'espace, choisis le programme et installe tout le monde confortablement. Une activité simple pour créer une ambiance festive, se détendre et passer un moment complice.",
            duration: 60,
            likes: 659,
            emplacements: [.home, .inside],
            category: .kitchen,
            materialsNeeded: ["Maïs à éclater", "Plaid", "Bon film"],
            numberOfParticipants: 5,
            difficulty: 1
        ),
        Activity(
            actionText: "Offre un",
            productName: "cadeau",
            imageName: "gift",
            gallery: ["gift_gal1", "gift_gal2"],
            description: "Prépare un cadeau personnalisé pour faire plaisir à quelqu'un. Décore une boîte, emballe un petit objet, ajoute un ruban et pourquoi pas un dessin ou un mot doux. Cette activité créative apprend à soigner les détails, à penser aux autres et à offrir avec le sourire.",
            duration: 45,
            likes: 1200,
            emplacements: [.home, .inside],
            category: .drawing,
            materialsNeeded: ["Boîte", "Papier cadeau", "Ruban", "Ciseaux", "Scotch"],
            numberOfParticipants: 2,
            difficulty: 2
        ),
        Activity(
            actionText: "Cuisine des",
            productName: "crêpes",
            imageName: "crepes",
            gallery: ["crepes_1", "crepes_2"],
            description: "Cuisine de bonnes crêpes maison en mélangeant la farine, les œufs et le lait, puis en garnissant chaque crêpe selon les envies. Chocolat, sucre ou confiture, chacun peut créer sa version. Une activité conviviale pour apprendre une recette simple et partager un goûter réussi.",
            duration: 45,
            likes: 24,
            emplacements: [.home, .inside],
            category: .kitchen,
            materialsNeeded: ["Farine", "Œufs", "Lait", "Chocolat"],
            numberOfParticipants: 3,
            difficulty: 2
        ),
        Activity(
            actionText: "Cherche le",
            productName: "trésor",
            imageName: "tresor",
            gallery: ["garden_map", "kids_running"],
            description: "Organise une chasse au trésor pleine d'aventure dans le jardin ou au parc. Dessine une carte, prépare des indices, cache de petits objets et lance les participants sur la piste. Cette activité stimule l'imagination, la coopération, l'orientation et le plaisir de chercher ensemble.",
            duration: 60,
            likes: 42,
            emplacements: [.garden, .outside, .park],
            category: .sport,
            materialsNeeded: ["Papier", "Feutres", "Petits objets à cacher"],
            numberOfParticipants: 4,
            difficulty: 3
        ),
        Activity(
            actionText: "Crée un",
            productName: "herbier",
            imageName: "herbier",
            gallery: ["leaf_1", "leaf_2"],
            description: "Crée un herbier en récoltant doucement des feuilles tombées au sol, puis en les collant dans un cahier avec leur nom ou une petite note. Une activité nature qui apprend à observer les formes, les couleurs et les saisons, tout en construisant un joli souvenir.",
            duration: 90,
            likes: 15,
            emplacements: [.forest, .park, .countryside],
            category: .nature,
            materialsNeeded: ["Feuilles d'arbres", "Cahier", "Colle"],
            numberOfParticipants: 2,
            difficulty: 1
        ),
        Activity(
            actionText: "Fais de la",
            productName: "peinture",
            imageName: "peinture",
            gallery: ["paint_1"],
            description: "Installe un grand papier et laisse libre cours aux couleurs avec de la peinture lavable. Les enfants peuvent peindre avec des pinceaux, les doigts ou des formes simples. Une activité artistique joyeuse pour explorer les mélanges, exprimer ses émotions et créer sans pression.",
            duration: 30,
            likes: 50,
            emplacements: [.home, .garden],
            category: .drawing,
            materialsNeeded: ["Peinture lavable", "Grand rouleau de papier"],
            numberOfParticipants: 3,
            difficulty: 1
        ),
        Activity(
            actionText: "Fabrique un",
            productName: "volcan",
            imageName: "volcan",
            gallery: ["volcano_1", "volcano_2"],
            description: "Fabrique un volcan miniature et observe une éruption amusante avec du bicarbonate, du vinaigre et un peu de colorant. Prépare le décor, verse les ingrédients et regarde la mousse jaillir. Une expérience scientifique spectaculaire pour découvrir les réactions tout en s'amusant.",
            duration: 40,
            likes: 88,
            emplacements: [.home, .garden, .inside],
            category: .sciences,
            materialsNeeded: ["Bicarbonate de soude", "Vinaigre blanc", "Colorant rouge"],
            numberOfParticipants: 2,
            difficulty: 2
        )
    ]
    
    static let motherId = UUID()
    static let fatherId = UUID()
    static let bigGirlId = UUID()
    static let boyId = UUID()
    static let littleGirlId = UUID()
    
    
    static let familyUsers: [User] = [
        User(
            id: motherId,
            name: "Kelly",
            age: 38,
            avatarName: "Avatar1",
            totalTime: 180,
            activities: [activities[0], activities[8]],
            interests: [.kitchen, .nature, .drawing],
            favoriteActivities: [activities[0].id, activities[5].id]
        ),
        User(
            id: fatherId,
            name: "Fabian",
            age: 40,
            avatarName: "Avatar2",
            totalTime: 210,
            activities: [activities[1]],
            interests: [.sport, .sciences],
            favoriteActivities: [activities[1].id]
        ),
        User(
            id: bigGirlId,
            name: "Imane",
            age: 11,
            avatarName: "Avatar3",
            totalTime: 120,
            activities: [],
            interests: [.drawing, .sciences, .kitchen],
            favoriteActivities: [activities[7].id]
        ),
        User(
            id: boyId,
            name: "Alexis",
            age: 6,
            avatarName: "Avatar4",
            totalTime: 90,
            activities: [],
            interests: [.sport, .nature],
            favoriteActivities: [activities[1].id, activities[3].id]
        ),
        User(
            id: littleGirlId,
            name: "Sridja",
            age: 7,
            avatarName: "Avatar5",
            totalTime: 95,
            activities: [],
            interests: [.kitchen, .drawing],
            favoriteActivities: [activities[2].id, activities[4].id]
        )
    ]
    
    static let family: Family = Family(name: "Famille Simplon", users: familyUsers)
    
    static let userLogs: [UserLog] = [
        UserLog(userID: motherId, activityID: activities[0].id, date: Date().addingTimeInterval(-86400), duration: 16),
        UserLog(userID: fatherId, activityID: activities[1].id, date: Date().addingTimeInterval(-172800), duration: 60),
        UserLog(userID: boyId, activityID: activities[1].id, date: Date().addingTimeInterval(-172800), duration: 60)
    ]
}
