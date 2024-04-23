//
//  CustomTabBarView.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 18.03.2024.
//

import SwiftUI

struct CustomTabBarView: View {
    
    @State private var tabSelection = 1
    @EnvironmentObject var mainViewModel: MainViewModel
    private let coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch tabSelection {
            case 1:
                NavigationView {
                    MainContent()
                }
            case 2:
                NavigationView {
                    CategoriesView(
                        mode: .screen,
                        viewModel: CategoriesViewModel(coordinator: coordinator)
                    )
                }
            case 3:
                NavigationView {
                    BookmarksView(viewModel: BookmarksViewModel())
                }
            case 4:
                NavigationView {
                    ProfileView(viewModel: ProfileViewModel(coordinator: coordinator))
                }
            default:
                NavigationView {
                    MainContent()
                }
            }
            CustomTabBar(tabSelection: $tabSelection)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CustomTabBarView(coordinator: Coordinator())
        .environmentObject(MainViewModel())
}
