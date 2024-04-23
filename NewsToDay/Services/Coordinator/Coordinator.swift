//
//  Coordinator.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 07.04.2024.
//

import Foundation
import Firebase
import FirebaseCore
import DS

final class Coordinator: ObservableObject {
    
    private let storage = StorageManager.shared
    
    enum NavigationState {
        case onboarding
        case category
        case auth
        case registration
        case main
    }
    
    enum CoordinatorAction {
        case onboardingCompleted
        case userAuthenticated
        case userRegistered
        case userRegister
        case categoryChosen
        case userSignOut
    }
    
    @Published var navigationState: NavigationState = .onboarding
    
    init() {
        updateNavigationState(action: .onboardingCompleted)
    }
    
    private func reduce(_ state: NavigationState, action: CoordinatorAction) -> NavigationState {
        var newState = state
        
        switch action {
        case .onboardingCompleted:
            newState = rootState(state: newState)
        case .userAuthenticated:
            newState = storage.hasChooseCategory() ? .main : .category
            
        case .categoryChosen:
            newState = .main
            
        case .userRegister:
            newState = .registration
            
        case .userRegistered:
            newState = .auth
            
        case .userSignOut:
            newState = .onboarding
        }
        return newState
    }
    
    func updateNavigationState(action: CoordinatorAction) {
        Task {
            await MainActor.run {
                navigationState = reduce(navigationState, action: action)
            }
        }
    }
    
    private func rootState(state: NavigationState) -> NavigationState {
        var newState = state
        if storage.hasCompletedOnboarding() {
            newState = Auth.auth().currentUser == nil ?  .auth : .main
        } else {
            newState = .onboarding
            storage.completeOnboarding()
        }
        return newState
    }
}
