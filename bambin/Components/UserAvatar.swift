//
//  MyFamilyAvatar.swift
//  bambin
//
//  Created by Apprenant154 on 11/06/2026.
//

import SwiftUI
import UIKit

struct UserAvatar: View {
    
    var user: User
    var size: CGFloat = 88
    
    var body: some View {
        avatarImage
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipShape(.circle)
    }
    
    private var avatarImage: Image {
        if let avatarImageData = user.avatarImageData,
           let uiImage = UIImage(data: avatarImageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image(user.avatarName)
        }
    }
}

#Preview {
    UserAvatar(user: MockData.family.users[1])
}
