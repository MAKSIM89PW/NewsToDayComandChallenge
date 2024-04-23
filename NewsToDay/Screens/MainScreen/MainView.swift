//
//  MainView.swift
//  NewsToDay
//
//  Created by dsm 5e on 17.03.2024.
//

import SwiftUI
import DS
import NetworkManager

struct MainView<D: View>: View {
    @Binding var query: String
    @Binding var selectedCategory: Categories
    
    let categories: [Categories]
    let language: Language
    var isSearching: Bool
    
    let categoryResults: MainDomainReducer.State.NewsState
    let recommendedResults: MainDomainReducer.State.NewsState
    let selectedBookmarks: Set<NewsResults>
    let destination: (NewsResults) -> D
    let manageBookmarks: (NewsResults) -> Void
    let reloadTap: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                ScreenHeader(title: "Discover things of this world")
                SearchBar(text: $query)
                
                if !isSearching {
                    HorizontalSelector(categories, spacing: 0) { category in
                        CategoryCell(category: category, selected: $selectedCategory)
                    }
                    HorizontalNewsCollection(
                        newsState: categoryResults, 
                        bookmarks: selectedBookmarks,
                        destination: destination,
                        manageBookmarks: manageBookmarks,
                        reloadTap: reloadTap
                    )
                    SectionTitle(
                        sectionTitle: "Recomended for you".localized(language),
                        buttonTitle: "See all".localized(language),
                        item: EmptyView()
                    )
                    VerticalNewsCollection(newsState: recommendedResults)
                } else {
                    VerticalNewsCollection(newsState: recommendedResults)
                }
            }
        }
        .animation(.bouncy, value: isSearching)
    }
}

extension MainView: Equatable {
    static func == (lhs: MainView<D>, rhs: MainView<D>) -> Bool {
        guard
            lhs.query == rhs.query,
            lhs.selectedCategory == rhs.selectedCategory,
            lhs.categories == rhs.categories,
            lhs.selectedBookmarks == rhs.selectedBookmarks,
            lhs.language == rhs.language,
            lhs.isSearching == rhs.isSearching,
            lhs.categoryResults == rhs.categoryResults,
            lhs.recommendedResults == rhs.recommendedResults
        else {
            return false
        }
        return true
    }
}

#Preview {
    NavigationView {
        MainView(
            query: .constant(""),
            selectedCategory: .constant(.business),
            categories: Categories.allCases,
            language: .ru,
            isSearching: false,
            categoryResults: .success([NewsResults.preview]),
            recommendedResults: .success([NewsResults.preview, NewsResults.preview]), 
            selectedBookmarks: [.preview],
            destination: { _ in EmptyView() },
            manageBookmarks: { _ in }, 
            reloadTap: {}
        )
    }
}
