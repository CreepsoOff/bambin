//
//  OnBoarding.swift
//  bambin
//
//  Created by Apprenant154 on 07/06/2026.
//

import SwiftUI

struct OnBoarding: View {
    
var onFinish: () -> Void
    
@State private var searchText: String = ""

    var body: some View {
        

        ZStack {

            // background
            ZStack {
                Color.lavender

                Image("backgroundPattern")
                    .resizable(resizingMode: .tile)
                    .opacity(0.25)
                    .blendMode(.multiply)
            }
            .ignoresSafeArea()

            VStack(spacing: 22) {

                Spacer()

                // Logo
                Image("reward1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 8)
                    .padding(.bottom, 10)

                // titre
                Text("Découvrez Bambin")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)

                // slogan
                Text("Des activités simples et créatives pour grandir ensemble, loin des écrans.")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 32)
                    .lineSpacing(4)

                Spacer()

                // Button
                VStack(spacing: 12) {

                    Button {

                        onFinish()

                    } label: {
                        Text("Commencer")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.85))
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                    }
                    

                    Text("Aucune inscription obligatoire")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 24)

                Spacer(minLength: 20)
            }
        }
    }
}


#Preview {
    NavigationStack {
        OnBoarding(onFinish: {})
    }
}
