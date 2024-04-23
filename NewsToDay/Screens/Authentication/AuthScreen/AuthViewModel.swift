//
//  AuthViewModel.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 25.03.2024.
//

import Foundation
import Firebase
import SwiftUI


class AuthViewModel: ObservableObject {
    // MARK: Stored Properties
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isPresented = false
    @Published var isPresentError: Bool = false
    
    @Published var errorMessage: String?
    
    private let coordinator: Coordinator
    private let authManager: AuthManagerWithFirebase
    
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    // MARK: Initialization
    init(authManager: AuthManagerWithFirebase = .shared,
         coordinator: Coordinator) {
        self.authManager = authManager
        self.coordinator = coordinator
        fetchUser()
        
    }
    
    // MARK: Methods
    func signIn() {
        Task {
            do {
                _ = try await authManager.signIn(withEmail: email, password: password)
                userAuthenticated()
            } catch {
                isPresentError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func fetchUser() {
        Task {
            do {
                await authManager.fetchUser()
            }
        }
    }
    
    //MARK: - NavigationState
    
    func userAuthenticated() {
        coordinator.updateNavigationState(action: .userAuthenticated)
    }
    
    func userRegister() {
        coordinator.updateNavigationState(action: .userRegister)
    }
}

