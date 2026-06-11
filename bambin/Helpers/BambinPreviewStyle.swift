//
//  BambinPreviewStyle.swift
//  bambin
//
//  Created by Apprenant154 on 11/06/2026.
//

import SwiftUI

struct BambinPreviewStyle: PreviewModifier {
    func body(content: Content, context: Void) -> some View {
        content
            .fontDesign(.rounded)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var bambin: Self {
        .modifier(BambinPreviewStyle())
    }
}
