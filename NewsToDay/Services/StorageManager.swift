//
//  StorageManager.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 07.04.2024.
//

import Foundation
import SwiftUI

final class StorageManager {
    // MARK: - Properties
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    
    enum UserDefaultKeys {
        static let hasSeenOnboarding = "hasSeenOnboarding"
        static let hasChooseCategory = "hasChooseCategory"
        static let chooseCategory = "chooseCategory"
        static let profileUser = "profileUser"
    }
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Onboarding
    func completeOnboarding() {
        userDefaults.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    func hasCompletedOnboarding() -> Bool {
        userDefaults.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    // MARK: - Categories
    func saveCategories(categories: [Categories]) {
        let categoriesArray = categories.map(\.rawValue)
        userDefaults.set(categoriesArray, forKey: UserDefaultKeys.chooseCategory)
    }
    
    func loadCategories() -> [Categories]? {
        userDefaults
            .array(forKey: UserDefaultKeys.chooseCategory)
            .flatMap { $0 as? [String] }
            .map { $0.compactMap(Categories.init) }
    }
    
    func hasChooseCategory() -> Bool {
        let hasChooseCategory = userDefaults.bool(forKey: UserDefaultKeys.hasChooseCategory)
        return hasChooseCategory
    }
    
    // MARK: - Profile
    func saveProfileImage(_ image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            userDefaults.set(imageData, forKey: UserDefaultKeys.profileUser)
        }
    }

    func loadProfileImage() -> UIImage? {
        if let imageData = userDefaults.data(forKey: UserDefaultKeys.profileUser) {
            return UIImage(data: imageData)
        }
        return nil
    }
}
