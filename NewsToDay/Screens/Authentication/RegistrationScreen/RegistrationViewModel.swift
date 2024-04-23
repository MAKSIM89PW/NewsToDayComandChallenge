//
//  RegistrationViewModel.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 28.03.2024.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var userName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var repeatPassword = ""
    @Published var isPresentError: Bool = false
    @Published var errorMessage: String?

    
    var formIsValid: Bool {
        return !userName.isEmpty
        && !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && repeatPassword == password
    }
    
    var passwordCheck: Bool {
        return !repeatPassword.isEmpty
        && repeatPassword == password
    }
   
    private let authManager: AuthManagerWithFirebase
    private let coordinator: Coordinator
    
    // MARK: Initialization
    init(authManager: AuthManagerWithFirebase = .shared,
         coordinator: Coordinator) {
        self.authManager = authManager
        self.coordinator = coordinator
    }
    
    // MARK: Methods
    func createUsers() {
        Task {
            do {
                _ = try await authManager.createUser(
                    email: email,
                    password: password,
                    userName: userName
                )
            } catch {
                isPresentError = true
                errorMessage = error.localizedDescription
            }
        }
    }
    
    //MARK: - NavigationState
    func userRegistered() {
        coordinator.updateNavigationState(action: .userRegistered)
    }
}

