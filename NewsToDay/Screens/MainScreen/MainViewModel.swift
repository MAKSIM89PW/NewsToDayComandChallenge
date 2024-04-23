//
//  MainViewModel.swift
//  NewsToDay
//
//  Created by dsm 5e on 17.03.2024.
//

import Combine
import Foundation
import NetworkManager

@dynamicMemberLookup
final class MainViewModel: ObservableObject {
    @Published var state: MainDomainReducer.State = .init()
    private let reducer: MainDomainReducer.Reducer
    private let networkManager = NetworkManager.shared
    private let storageManager = StorageManager.shared
    
    //MARK: - init(_:)
    init(reducerDomain: MainDomainReducer = .init()) {
        reducer = reducerDomain.reduce
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<MainDomainReducer.State, T>) -> T {
        state[keyPath: keyPath]
    }
    
    func dispatch(_ action: MainDomainReducer.Action) {
        Task(priority: .high) { [weak self] in
            guard let self else { return }
            let newState = reducer(state, action)
            
            await MainActor.run {
                self.state = newState
            }
            if action == .onAppear {
                loadCategories()
                    .map(dispatch)
            }
            if newState.recommendedResults == .loading {
                let action = newState.isSearching
                ? await searchNews(newState.query)
                : await fetchRecommendedNews(newState)
                dispatch(action)
            }
            if newState.categoryNews == .loading {
                await fetchCategoryNews(newState)
                    .map(dispatch)
            }
        }
    } 
}

private extension MainViewModel {
    func loadCategories() -> MainDomainReducer.Action? {
        storageManager
            .loadCategories()
            .map(MainDomainReducer.Action.updateCategories)
    }
    
    func fetchRecommendedNews(_ state: MainDomainReducer.State) async -> MainDomainReducer.Action {
        let categories = state.categories
            .prefix(5)
            .map(\.rawValue)
            .joined(separator: ",")
        let lang = state.lang.rawValue
        
        switch await networkManager
            .recommendedNews(categories: categories, lang: lang)
            .map(\.results)
            .map(MainDomainReducer.Action._recommendedSuccess)
            .mapError(MainDomainReducer.Action._recommendedFail) {
        case let .success(success):
            return success
            
        case let .failure(fail):
            return fail
        }
    }
    
    func fetchCategoryNews(_ state: MainDomainReducer.State) async -> MainDomainReducer.Action? {
        switch await Optional(state)
            .map({ ($0.lang, $0.selectedCategory) })
            .map({ ($0.rawValue, $1.rawValue) })
            .asyncMap(networkManager.getLatestNews)?
            .map(\.results)
            .map(MainDomainReducer.Action._categorySuccess)
            .mapError(MainDomainReducer.Action._categoryFail) {
        case let .success(successAction):
            return successAction
            
        case let .failure(failureAction):
            return failureAction
            
        case .none:
            return nil
        }
    }
    
    func searchNews(_ query: String) async -> MainDomainReducer.Action {
        switch await networkManager
            .getNewsWith(searchText: query)
            .map(\.results)
            .map(MainDomainReducer.Action._recommendedSuccess)
            .mapError(MainDomainReducer.Action._recommendedFail) {
        case let .success(success):
            return success
            
        case let .failure(fail):
            return fail
        }
    }
}
