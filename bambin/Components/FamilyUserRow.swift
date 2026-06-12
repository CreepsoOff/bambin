//
//  FamilyUserRow.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//

import SwiftUI

struct FamilyUserRow: View {
    let user: User

    var body: some View {
        HStack(spacing: 8) {
            UserAvatar(user: user, size: 52)
                

            Text(user.name)
                .font(.body)
                .foregroundStyle(.black)

            Spacer()
        }
    }
}

#Preview(traits: .bambin) {
    FamilyUserRow(user: MockData.family.users[0])
}
