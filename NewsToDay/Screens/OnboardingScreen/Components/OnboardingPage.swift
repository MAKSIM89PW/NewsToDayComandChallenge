//
//  OnboardingPage.swift
//  NewsToDay
//
//  Created by dsm 5e on 28.03.2024.
//

import SwiftUI

struct OnboardingPage {
    var title: String
    var description: String
    var image: String
    
    static let pages: [OnboardingPage] = {
        @AppStorage("selectedLanguage") var language = LocalizationManager.shared.language
        return [
            OnboardingPage(
                title: "Stay informed".localized(language),
                description: "Get the latest news and updates from around the world.",
                image: "onboarding1"
            ),
            OnboardingPage(
                title: "Feed based on your interests".localized(language),
                description: "Choose topics that interest you, and we'll create a personalized news feed just for you.",
                image: "onboarding2"
            ),
            OnboardingPage(
                title: "Save and share".localized(language),
                description: "Save articles for later reading and share your favorite stories with friends.",
                image: "onboarding3"
            )
        ]
    }()
}
