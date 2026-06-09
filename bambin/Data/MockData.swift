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
            productName: "PIZZA",
            imageName: "pizza",
            gallery: ["pizza_gal1", "pizza_gal2"],
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
            productName: "BASKET",
            imageName: "basketball",
            gallery: ["basket_gal1"],
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
            productName: "OEUF",
            imageName: "egg",
            gallery: ["egg_gal1", "egg_gal2"],
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
            productName: "FORÊT",
            imageName: "tree",
            gallery: ["forest_gal1", "forest_gal2", "forest_gal3"],
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
            productName: "PAPILLONS",
            imageName: "butterflies",
            gallery: ["butterfly_gal1"],
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
            productName: "BURGER",
            imageName: "hamburger",
            gallery: ["burger_gal1", "burger_gal2"],
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
            productName: "SOIRÉE",
            imageName: "popcorn",
            gallery: ["popcorn_gal1"],
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
            productName: "CADEAU",
            imageName: "gift",
            gallery: ["gift_gal1", "gift_gal2"],
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
            productName: "CRÊPES",
            imageName: "crepes_photo",
            gallery: ["crepes_1", "crepes_2"],
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
            productName: "TRÉSOR",
            imageName: "nature_run",
            gallery: ["garden_map", "kids_running"],
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
            productName: "HERBIER",
            imageName: "herbier_img",
            gallery: ["leaf_1", "leaf_2"],
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
            productName: "PEINTURE",
            imageName: "paint_fingers",
            gallery: ["paint_1"],
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
            productName: "VOLCAN",
            imageName: "volcano_exp",
            gallery: ["volcano_1", "volcano_2"],
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
    
    static let family: [User] = [
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
    
    static let userLogs: [UserLog] = [
        UserLog(userID: motherId, activityID: activities[0].id, date: Date().addingTimeInterval(-86400), duration: 16),
        UserLog(userID: fatherId, activityID: activities[1].id, date: Date().addingTimeInterval(-172800), duration: 60),
        UserLog(userID: boyId, activityID: activities[1].id, date: Date().addingTimeInterval(-172800), duration: 60)
    ]
}
