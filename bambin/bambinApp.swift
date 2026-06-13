//
//  bambinApp.swift
//  bambin
//
//  Created by Apprenant154 on 05/06/2026.
//

import SwiftUI

@main
struct bambinApp: App {
//    init() {
//        let appearance = UINavigationBarAppearance()
//        
//        do {
//            let base = UIFont.preferredFont(forTextStyle: .headline)
//            let desc = base.fontDescriptor.withDesign(.rounded) ?? base.fontDescriptor
//            let rounded = UIFont(descriptor: desc, size: 0)
//            appearance.titleTextAttributes = [
//                .font: UIFontMetrics(forTextStyle: .headline).scaledFont(for: rounded)
//            ]
//        }
//        
//        do {
//            let base = UIFont.preferredFont(forTextStyle: .largeTitle)
//            let weighted = UIFont.systemFont(ofSize: base.pointSize, weight: .bold)
//            let desc = weighted.fontDescriptor.withDesign(.rounded) ?? weighted.fontDescriptor
//            let roundedWeighted = UIFont(descriptor: desc, size: 0)
//            appearance.largeTitleTextAttributes = [
//                .font: UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: roundedWeighted)
//            ]
//        }
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
    
    var body: some Scene {
        WindowGroup {
                   ContentView()
                       .fontDesign(.rounded)
        }
    }
}

