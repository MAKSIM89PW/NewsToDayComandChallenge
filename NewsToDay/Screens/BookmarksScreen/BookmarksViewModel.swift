//
//  BookmarksViewModel.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 08.04.2024.
//

import Foundation
import NetworkManager

final class BookmarksViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var bookmarks: Set<NewsResults> = []
    
    // MARK: Initialization
    init() {
    
    }
    // MARK: Methods
    
}
