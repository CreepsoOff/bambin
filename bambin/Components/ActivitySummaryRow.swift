//
//  ActivitySummaryRow.swift
//  bambin
//
//  Created by Apprenant154 on 12/06/2026.
//


import SwiftUI

struct ActivitySummaryRow: View {
    
    let activity: Activity
    
    var body: some View {
        HStack(spacing: 12) {
            Image(activity.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(activity.actionText) \(activity.productName)")
                    .font(.body)
                    .foregroundStyle(.primary)
                
                Text(activity.category.rawValue)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("\(activity.duration) min")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ActivitySummaryRow(activity: MockData.activities[0])
}