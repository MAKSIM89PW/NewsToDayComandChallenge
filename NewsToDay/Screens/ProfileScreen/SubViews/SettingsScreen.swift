//
//  SettingsScreen.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 20.03.2024.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            AuthTitle(title: "Language selection".localized(language))
            CustomButton(
                title: "English".localized(language),
                imageName: "checkmark",
                action: {
                    language = .en
                }, buttonType: .language,
                isSelected: language == .en)
            .padding(.horizontal)
//            .padding([.horizontal, .top])
            
            CustomButton(
                title: "Russian".localized(language),
                imageName: "checkmark",
                action: {
                    language = .ru
                }, buttonType: .language,
                isSelected:
                    language == .ru)
            .padding([.horizontal, .top])
            
            AuthTitle(title: "Theme selection".localized(language))
            
            CustomButton(
                title: "Dark Mode".localized(language),
                imageName: "checkmark",
                action: {
                    // action
                }, buttonType: .mode,
                isSelected: colorScheme == .dark)
                .padding(.horizontal)
//            .padding([.horizontal, .top])
            
            CustomButton(
                title: "Light Mode".localized(language),
                imageName: "checkmark",
                action: {
                    // action
                }, buttonType: .mode,
                isSelected: colorScheme == .light)
            .padding([.horizontal, .top])
            
            Spacer()
        }
        .toolbar(content: BackBarButton.blueArrow)
        .navigationTitle("Settings".localized(language))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        SettingsScreen()
    }
}
