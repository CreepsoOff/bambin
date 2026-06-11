//
//  MyFamilyAvatar.swift
//  bambin
//
//  Created by Apprenant154 on 11/06/2026.
//

import SwiftUI

struct UserAvatar: View {
    
    var user: User
    
    var body: some View {
        Image(user.avatarName)
            .resizable()
            .frame(width: 88, height: 88)
            .clipShape(.circle)
    }
}

#Preview {
    UserAvatar(user: MockData.family.users[1])
}
