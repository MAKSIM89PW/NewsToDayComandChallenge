//
//  MainContent.swift
//  NewsToDay
//
//  Created by Илья Шаповалов on 19.03.2024.
//

import SwiftUI
import DS

struct MainContent: View {
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        MainView(
            query: bindSearchQuery(),
            selectedCategory: bindSelectedCategory(),
            categories: viewModel.categories,
            language: language,
            isSearching: viewModel.isSearching,
            categoryResults: viewModel.categoryNews,
            recommendedResults: viewModel.recommendedResults,
            selectedBookmarks: viewModel.bookmarks,
            destination: { news in
                DetailView(
                    item: news,
                    isBookmark: viewModel.bookmarks.contains(news),
                    action: { viewModel.dispatch(.selectBookmark(news)) }
                )
            },
            manageBookmarks: { viewModel.dispatch(.selectBookmark($0)) }, 
            reloadTap: {
                #warning("Дописать обработку нажатия кнопки перезапуска")
            }
        )
        .equatable()
        .onAppear { viewModel.dispatch(.onAppear) }
        .navigationTitle("Browse".localized(language))
    }
}

//MARK: - Private methods
private extension MainContent {
    func bindSearchQuery() -> Binding<String> {
        Binding(
            get: { viewModel.state.query },
            set: { viewModel.dispatch(.updateQuery($0)) }
        )
    }
    
    func bindSelectedCategory() -> Binding<Categories> {
        Binding(
            get: { viewModel.state.selectedCategory },
            set: { viewModel.dispatch(.selectCategory($0)) }
        )
    }
}

#Preview {
    MainContent()
        .environmentObject(MainViewModel())
}








