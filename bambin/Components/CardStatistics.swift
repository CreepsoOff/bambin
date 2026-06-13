//
//  CardStatisticsView.swift
//  bambin
//
//  Created by Imane on 09/06/2026.
//

import SwiftUI


// COMPOSANT (VUE RÉUTILISABLE) CARTE STATISTIQUE
struct CardStatistics: View {
    
    // Données injectés
    let title: String
    let text: String
    let backgroundColor: Color
    
    var body: some View {
        
        ZStack {
            
            // Style de la carte
            RoundedRectangle(cornerRadius: 7)
                .stroke(.white, lineWidth: 6)
                .frame(maxWidth: 175, maxHeight: 132)
                .background(backgroundColor)
            
            VStack {
                
                // Titre
                Text(title)
                    .font(.system(size: 14).bold())
                    .padding(.bottom, 5)
                
                // Valeur principal
                Text(text)
                    .font(.system(size: 40, weight: .black))
                
            }
            .padding()
            .foregroundStyle(.primary)
        }
    }
}


#Preview {
    
    // variables local pour test
    let hour = 20
    let minute = 15
    
    // Instanciation de la vue
    CardStatistics(
        
        // Titre affiché
        title: "Heure sans écrans",
        
        // interpolation + formatage = 20h15
        // format: "%02d" = force 2 chiffres
        text: "\(hour)h\(String(format: "%02d", minute))",
        
        // couleur du background pour la vue
        backgroundColor: .green
    )
    
}
