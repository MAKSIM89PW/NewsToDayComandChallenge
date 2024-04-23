//
//  NewsToDayApp.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 17.03.2024.
//




import SwiftUI
import Firebase
import FirebaseCore
import DS

@main
struct NewsToDayApp: App {
    
    init() {
        FirebaseApp.configure()
        FontsProvider.registerFonts()
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font : DS.Fonts.largeTitle ??
                .italicSystemFont(ofSize: 24)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
    }
}



