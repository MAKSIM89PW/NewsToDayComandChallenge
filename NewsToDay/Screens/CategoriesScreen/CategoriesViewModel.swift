//
//  CategoriesViewModel.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 02.04.2024.
//

import SwiftUI

final class CategoriesViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var categories: [Categories] = []
    
    private let storageManager = StorageManager.shared
    private let coordinator: Coordinator
    
    // MARK: Initialization
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        loadCategories()
    }
    
    // MARK: Methods
    func saveCategories() {
        storageManager.saveCategories(categories: categories)
    }
    
    func loadCategories() {
        self.categories = storageManager.loadCategories() ?? []
    }
    
    // MARK: - NavigationState
    func categoryChosen() {
        coordinator.updateNavigationState(action: .categoryChosen)
    }
}
