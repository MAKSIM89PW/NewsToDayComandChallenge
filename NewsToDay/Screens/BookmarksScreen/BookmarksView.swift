//
//  BookmarksView.swift
//  NewsToDay
//
//  Created by dsm 5e on 23.03.2024.
//

import SwiftUI
import DS

struct BookmarksView: View {
    
    @ObservedObject var viewModel: BookmarksViewModel
    
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    
    var body: some View {
        VStack {
            ScreenHeader(title: "Saved articles to the library".localized(language))
            if viewModel.bookmarks.isEmpty {
                VStack(spacing: 24) {
                    Spacer()
                    ZStack {
                        Circle()
                            .frame(width: 72, height: 72)
                            .foregroundColor(DS.Colors.Theme.indigoAccent.opacity(0.5))
                        Image(systemName: "text.book.closed")
                            .font(DS.Fonts.Inter28.extraBold)
                            .foregroundColor(DS.Colors.Theme.whiteAccent)
                    }
                    
                    Text("You haven't saved any articles yet. Start reading and bookmarking them now".localized(language))
                        .font(DS.Fonts.Inter16.medium500)
                        .padding(.horizontal, 50)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding()
                
            } else {
                ScrollView {
                    ForEach(Array(viewModel.bookmarks)) { bookmark in
                        NavigationLink {
                            DetailView(item: bookmark, isBookmark: viewModel.bookmarks.contains(bookmark)) {
                                
                            }
                        } label: {
                            RecommendedCell(item: bookmark)
                        }
                    }
                }
            }
        }
        .navigationTitle("Bookmarks".localized(language))
    }
}

#Preview {
    NavigationView {
        BookmarksView(viewModel: BookmarksViewModel())
    }
}
