//
//  HorizontalNewsCollection.swift
//  NewsToDay
//
//  Created by Илья Шаповалов on 30.03.2024.
//

import SwiftUI
import NetworkManager

struct HorizontalNewsCollection<D: View>: View {
    let newsState: MainDomainReducer.State.NewsState
    let bookmarks: Set<NewsResults>
    let destination: (NewsResults) -> D
    let manageBookmarks: (NewsResults) -> Void
    let reloadTap: () -> Void
    
    var body: some View {
        switch newsState {
        case .empty:
            EmptyView()
            
        case .loading:
            MainScreenWithShimmer()
            
        case .success(let news):
            HorizontalSelector(news) { news in
                NavigationLink(destination: destination(news)) {
                    ArticleCell(
                        urlString: news.imageUrl,
                        title: news.category?.first?.uppercased() ?? "",
                        description: news.title ?? "No title",
                        isBookmark: bookmarks.contains(news),
                        action: { manageBookmarks(news) }
                    )
                }
            }
            .equatable()
            
        case .error(let networkError):
            ErrorView(error: networkError, action: reloadTap) 
        }
    }
}

#Preview {
    HorizontalNewsCollection(
        newsState: .empty,
        bookmarks: [],
        destination: { _ in EmptyView() },
        manageBookmarks: { _ in }, 
        reloadTap: {}
    )
}
