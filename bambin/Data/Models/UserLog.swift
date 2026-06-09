//
//  UserLog.swift
//  bambin
//
//  Created by Apprenant154 on 08/06/2026.
//


import Foundation

struct UserLog: Identifiable, Hashable, Codable {
    var id = UUID()
    
    let userID: UUID
    let activityID: UUID
    let date: Date
    let duration: Int
}