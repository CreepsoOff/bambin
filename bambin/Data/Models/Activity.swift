//
//  Activity.swift
//  bambin
//
//  Created by Apprenant154 on 08/06/2026.
//

import Foundation

struct Activity: Identifiable, Hashable, Codable {
    var id = UUID()
    
    let actionText: String
    let productName: String
    let imageName: String
    let gallery: [String]
    let duration: Int
    var likes: Int
    
    let emplacements: [Emplacement]
    let category: Interet
    
    let materialsNeeded: [String]
    let numberOfParticipants: Int
    let difficulty: Int
}
