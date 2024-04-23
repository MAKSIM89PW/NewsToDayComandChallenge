//
//  OnboardingViewModel.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 07.04.2024.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var currentPage = 0
    
    private let coordinator: Coordinator
    
    // MARK: Initialization
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: Methods
    func goToNextPage() {
        currentPage += 1
    }
    
    //MARK: - NavigationState
    func onboardingCompleted() {
        coordinator.updateNavigationState(action: .onboardingCompleted)
    }
}
