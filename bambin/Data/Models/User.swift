//
//  User.swift
//  bambin
//
//  Created by Apprenant154 on 07/06/2026.
//

import Foundation

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
