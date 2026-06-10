//
//  ActivityView.swift
//  bambin
//
//  Created by apprenant130 on 10/06/2026.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ActivityCardView: View {
    var body: some View {
        ZStack {
            Color(.blue.opacity(0.2))
                .ignoresSafeArea()

            VStack {

                // Time and Like button
                HStack {
                    Text("45")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .foregroundStyle(.white)
                        .bold()
                        .background(
                            Color(.black.opacity(0.65))
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )
                        .shadow(radius: 4, y: 6)
                    Spacer()
                    Button {
                        print("Tapped heart.")
                    } label: {
                        HStack {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                            Text("349")
                                .foregroundStyle(.white)
                        }
                        .font(.callout)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .background(
                            Color(.black.opacity(0.65))
                        )
                        .clipShape(
                            RoundedRectangle(cornerRadius: 25)
                        )
                        .shadow(radius: 4, y: 6)
                    }
                }

                // Action sentence
                HStack {
                    Text("Cuisiner un")
                        .font(.title2)
                    Spacer()
                }
                .padding([.top], 20)

                // Subject sentence
                HStack {
                    Text("Burger")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }

                // Activity Image
                Image("hamburger")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128)

            }
            .frame(width: 150)
            .padding(.vertical, 20)
            .padding(.horizontal, 20)
            .background(
                Color(.cyan)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 25)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(.white, lineWidth: 8)
            )
        }
    }
}

#Preview {
    ActivityCardView()
}
