//
//  CardTopActivities.swift
//  bambin
//
//  Created by Apprenant131 on 11/06/2026.


import SwiftUI

struct CardTopActivities: View {
    
    let backgroundColor: Color
    let sticker : String
    let activityTheme : String
    let activityTitle : String
    let topImage : String
    let count : Int
    
    
    var body: some View {
        
        ZStack {
            Color.gray
            
            VStack {
                
                // Rectangle
                RoundedRectangle(cornerRadius: 7)
                    .stroke(.white, lineWidth: 6)
                    .frame(maxWidth: 370, maxHeight: 132)
                    .background(backgroundColor)
                    .overlay {
                        
                        HStack {
                            
                            // Sticker
                            Image(sticker)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth : 107)
                                .frame (maxHeight: 73)
                                .rotationEffect(.degrees(10))
                            
                            Spacer()
                            
                            // medaille
                            Image(topImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: 74)
                                .frame(maxHeight : 62)
                                
                            
                        }   .padding()
                            .foregroundStyle(.primary)
                        
                        
                        VStack (spacing: 10) {
                            
                            // Badge
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(maxWidth: 97)
                                    .frame(maxHeight : 27)
                                    .foregroundStyle(.white)
                                
                                Label(activityTheme.uppercased(), systemImage: "star.fill")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundStyle(backgroundColor)
                            }
                            
                            Text(activityTitle)
                                .font(.system(size: 16, weight: .bold))
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                
                                Text("\(count) fois jouées")
                            } .font(.system(size: 14))
                            
                        }
                    }
            }
        }
    }
}


#Preview {
    CardTopActivities(
        backgroundColor: .cyan,
        sticker: "egg",
        activityTheme: "creative",
        activityTitle : "Dessiner sur un oeuf",
        topImage: "reward1",
        count: 6
    )
}
