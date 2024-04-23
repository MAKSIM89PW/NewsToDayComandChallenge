//
//  MainDomainReducer.swift
//  NewsToDay
//
//  Created by Илья Шаповалов on 30.03.2024.
//

import Foundation
import NetworkManager

struct MainDomainReducer {
    typealias Reducer = (State, Action) -> State
    
    //MARK: - State
    struct State: Equatable {
        var query: String
        var categories: [Categories]
        var bookmarks: Set<NewsResults>
        var selectedCategory: Categories
        var categoryNews: NewsState
        var recommendedResults: NewsState
        var lang: Language
        var isSearching: Bool
        
        //MARK: - init(_:)
        init(
            query: String = .init(),
            categories: [Categories] = .init(),
            bookmarks: Set<NewsResults> = .init(),
            selectedCategory: Categories = .business,
            categoryNews: NewsState = .empty,
            recommendedResults: NewsState = .empty,
            lang: Language = .en,
            isSearching: Bool = false
        ) {
            self.query = query
            self.categories = categories
            self.bookmarks = bookmarks
            self.selectedCategory = selectedCategory
            self.categoryNews = categoryNews
            self.recommendedResults = recommendedResults
            self.lang = lang
            self.isSearching = isSearching
        }
        
        enum NewsState: Equatable, Error {
            case empty
            case loading
            case success([NewsResults])
            case error(NetworkError)
            
            static func == (lhs: Self, rhs: Self) -> Bool {
                String(describing: lhs) == String(describing: rhs)
            }
        }
    }
    
    //MARK: - Action
    enum Action: Equatable, Error {
        case onAppear
        case updateQuery(String)
        case selectCategory(Categories)
        case selectBookmark(NewsResults)
        case updateCategories([Categories])
        
        case _categorySuccess([NewsResults])
        case _categoryFail(NetworkError)
        
        case _recommendedSuccess([NewsResults])
        case _recommendedFail(NetworkError)
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            String(describing: lhs) == String(describing: rhs)
        }
    }
    
    //MARK: - Dependencies
    let bookmarksManager = BookmarksManager.shared
    
    //MARK: - Reducer
    func reduce(_ state: State, action: Action) -> State {
        var state = state
        switch action {
        case .onAppear:
            switch bookmarksManager
                .fetchBookmark()
                .map(Set.init) {
            case .success(let bookmarks):
                state.bookmarks = bookmarks
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            if state.categoryNews == .empty || state.categoryNews != .loading {
                state.categoryNews = .loading
            }
            if state.recommendedResults == .empty || state.recommendedResults != .loading {
                state.recommendedResults = .loading
            }
            
        case let .updateCategories(categories):
            state.categories = categories
            state.categories.first.map { selected in
                state.selectedCategory = selected
            }
            
        case let .updateQuery(query):
            state.query = query
            state.isSearching = !query.isEmpty
            state.recommendedResults = .loading
            
        case let .selectCategory(category):
            guard category != state.selectedCategory else { break }
            state.selectedCategory = category
            state.categoryNews = .loading
            
        case let .selectBookmark(news):
            switch state.bookmarks.contains(news) {
            case true: 
                _ = bookmarksManager
                    .removeBookmark(news)
                    .map { state.bookmarks.remove($0) }

            case false:
                _ = bookmarksManager
                    .saveBoormark(news)
                    .map { state.bookmarks.insert($0) }
            }
            
        case ._categorySuccess(let news):
            let unique = news.reduce(into: [NewsResults]()) { partialResult, news in
                if partialResult.first(where: { $0.title == news.title }) != nil {
                    return
                }
                partialResult.append(news)
            }
            state.categoryNews = .success(unique)
            
        case ._categoryFail(let error):
            state.categoryNews = .error(error)
            
        case ._recommendedSuccess(let news):
            state.recommendedResults = .success(news)
            
        case ._recommendedFail(let error):
            state.recommendedResults = .error(error)
        }
        return state
    }
}
