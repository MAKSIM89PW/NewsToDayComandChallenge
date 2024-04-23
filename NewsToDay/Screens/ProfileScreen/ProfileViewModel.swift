//
//  ProfileViewModel.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 29.03.2024.
//

import Firebase
import FirebaseAuth
import SwiftUI

final class ProfileViewModel: ObservableObject {
    // MARK: Stored Properties
    @Published var currentUser: UserModel?
    @Published var isPresented = false
    @Published var userPhoto: UIImage?
    
    var error: Error?
    
    private let storageManager = StorageManager.shared
    private let authManager = AuthManagerWithFirebase.shared
    private let coordinator: Coordinator
    
    // MARK: Initialization
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        updateCurrentUser()
//        fetchUser()
    }
    
    // MARK: Methods
    func updateCurrentUser() {
        currentUser = authManager.currentUser
    }
    
//    func fetchUser() {
//            Task {
//                await authManager.fetchUser()
//                await MainActor.run {
//                    self.currentUser = authManager.currentUser
//                }
//            }
//        }
    
    func didChangeProfileImage(_ image: UIImage) {
        StorageManager.shared.saveProfileImage(image)
    }
    
    func updateUserPhoto() {
        userPhoto = storageManager.loadProfileImage()
    }
    
    func signOut() {
        Task {
            do {
                try await authManager.signOut()
                openApp()
            } catch {
                
            }
        }
    }
    
    //MARK: - NavigationState
    func openApp() {
        coordinator.updateNavigationState(action: .userSignOut)
    }
}
