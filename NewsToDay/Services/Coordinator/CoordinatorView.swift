//
//  CoordinatorView.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 07.04.2024.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        Group {
            switch coordinator.navigationState {
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(coordinator: coordinator)
                )
            case .category:
                NavigationView {
                    CategoriesView(
                        mode: .onboarding,
                        viewModel: CategoriesViewModel(coordinator: coordinator))
                }
            case .auth:
                NavigationView {
                    AuthView(
                        authViewModel: AuthViewModel(coordinator: coordinator))
                }
            case .registration:
                NavigationView {
                    RegistrationView(
                        viewModel: RegistrationViewModel(coordinator: coordinator))
                }
            case .main:
                CustomTabBarView(coordinator: coordinator)
                    .environmentObject(MainViewModel())
            }
        }
        .animation(.bouncy, value: coordinator.navigationState)
    }
}
