//
//  Emplacement.swift
//  bambin
//
//  Created by Apprenant154 on 07/06/2026.
//

import Foundation

enum Emplacement: String, CaseIterable, Codable {
    case outside = "Plein air"
    case home = "À la maison"
    case garden = "Dans le jardin"
    case inside = "En intérieur"
    case city = "En ville"
    case park = "Au parc / Aire de jeux"
    case forest = "En forêt"
    case beach = "À la plage"
    case countryside = "À la campagne"
    case museum = "Au musée"
    case library = "À la bibliothèque / Ludothèque"
    case indoorPlayground = "Structure de jeux couverte"
    case cinema = "Au cinéma / Spectacle"
    case transport = "En voiture / Train / Avion"
    case vacation = "Sur le lieu de vacances"
}
