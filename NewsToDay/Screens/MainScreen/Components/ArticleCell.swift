//
//  ArticleCell.swift
//  NewsToDay
//
//  Created by Илья Шаповалов on 19.03.2024.
//

import SwiftUI
import DS
import NetworkManager

struct ArticleDetailView: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(DS.Fonts.Inter12.regular400)
                .padding(.bottom, 12)
            Text(description)
                .font(DS.Fonts.Inter16.bold700)
                .lineLimit(2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.5))
    }
}

struct ArticleCell: View {
    private struct Drawing {
        static let cardWidth: CGFloat = 256
        static let cardHeight: CGFloat = 256
        static let cornerRadius: CGFloat = 12
        static let bottomLeadingPadding: CGFloat = 12
        static let footnoteFontWeight: Font.Weight = .light
        static let headlineFontWeight: Font.Weight = .bold
        static let bookmarkImagePadding: CGFloat = 30
    }
    
    @Environment(\.displayScale) private var scale
    
    
    let urlString: String?
    let title: String
    let description: String
    let isBookmark: Bool
    let action: () -> Void
    
    var body: some View {
        ZStack {
            AsyncImageView(urlString)
                .frame(
                    width: Drawing.cardWidth,
                    height: Drawing.cardHeight
                )
                .foregroundStyle(DS.Colors.Theme.buttonText)
                .overlay(alignment: .bottomLeading) {
                    
                    ArticleDetailView(
                        title: title,
                        description: description
                    )
                    .frame(maxWidth: .infinity)
                    .cornerRadius(Drawing.cornerRadius)
                    .padding(Drawing.bottomLeadingPadding)
                }
            
                .overlay(alignment: .topTrailing) {
                    Button(action: action) {
                        Image(systemName: isBookmark ? "bookmark.fill" : "bookmark")
                            .font(.title)
                            .foregroundColor(isBookmark ? .red : DS.Colors.Theme.whiteAccent)
                    }
                    .padding(Drawing.bookmarkImagePadding)
                }
        }
        .foregroundColor(.white)
        .cornerRadius(Drawing.cornerRadius)
    }
    
    init(
        urlString: String?,
        title: String,
        description: String,
        isBookmark: Bool,
        action: @escaping () -> Void
    ) {
        self.urlString = urlString
        self.title = title
        self.description = description
        self.isBookmark = isBookmark
        self.action = action
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ArticleCell(urlString: "", title: "Title1", description: "Description1", isBookmark: true, action: {})
            ArticleCell(urlString: "", title: "Title2", description: "Description2", isBookmark: false, action: {})
        }
    }
}
