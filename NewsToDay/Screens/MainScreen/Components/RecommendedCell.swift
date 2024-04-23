//
//  RecommendedCell.swift
//  NewsToDay
//
//  Created by dsm 5e on 23.03.2024.
//

import SwiftUI
import DS
import NetworkManager

struct RecommendedCell: View {
    
    private struct Drawing {
        static let spacing: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let imageWidth: CGFloat = 96
        static let height: CGFloat = 96
        static let headlineFontSize: CGFloat = 18
        static let headlineFontWeight: Font.Weight = .light
        static let padding: CGFloat = 16
    }
    
    let item: NewsResults
    
    var body: some View {
        HStack(spacing: Drawing.spacing) {
            GeometryReader { geometry in
                AsyncImageView(item.imageUrl)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
            .foregroundColor(DS.Colors.Theme.indigoAccent)
            .frame(width: Drawing.imageWidth, height: Drawing.height)
            
            VStack(alignment: .leading, spacing: Drawing.spacing) {
                Text(item.creator?.joined(separator: ", ") ?? "")
                    .foregroundStyle(DS.Colors.Theme.grayLight)
                    .font(.headline.weight(Drawing.headlineFontWeight))
                
                Text(item.title ?? "default")
                    .foregroundStyle(DS.Colors.Theme.primaryText)
                    .font(DS.Fonts.Inter16.semiBold600)
            }
            Spacer()
        }
        .padding(.horizontal, Drawing.padding)
        .frame(maxWidth: .infinity)
        .frame(height: Drawing.height)
    }
}

#Preview {
    RecommendedCell(item: NewsResults.preview)
}
