//
//  CardStatisticsView.swift
//  bambin
//
//  Created by Apprenant131 on 09/06/2026.
//

import SwiftUI


// COMPOSANT (VUE RÉUTILISABLE) CARTE STATISTIQUE
struct CardStatistics: View {
    
    let title : String
    let backgroundColor: Color
    let hour : Int
    let minute : Int
    
    var body: some View {
    
        ZStack {
            
            RoundedRectangle(cornerRadius: 7)
                .stroke(.white, lineWidth: 6)
                .frame(maxWidth: 175, maxHeight: 132)
                .background(backgroundColor)
                .overlay {
                   
                    VStack {
                        
                        Text(title)
                            .font(.system(size: 14).bold())
                            
                        
                        Spacer()
                        
                        Text("\(hour)h\(minute)")
                            .font(.system(size: 40, weight: .black))

                        
                        Spacer()
                        
                    }   .padding()
                        .foregroundStyle(.primary)
                        .opacity(0.7)
               
            }
        }
    }
}

#Preview {
    CardStatistics(
        title: "Heure sans écrans",
        backgroundColor: .green,
        hour: 20,
        minute: 15
    )
}
