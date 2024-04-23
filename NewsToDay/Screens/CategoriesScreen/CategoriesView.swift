//
//  CategoriesView.swift
//  NewsToDay
//
//  Created by dsm 5e on 20.03.2024.
//

import SwiftUI
import DS

struct CategoriesView: View {
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    
    @ObservedObject var viewModel: CategoriesViewModel
    
    @State var mode: Mode = .screen
    
    enum Mode {
        case onboarding
        case screen
    }
    
    enum Drawing {
        static let columnsSpacing: CGFloat = 12
        static let columnsCount = 2
        static let cornerRadius: CGFloat = 8
        static let horizontalSpacing: CGFloat = 8
        static let verticalSpacing: CGFloat = 20
    }
    
    init(mode: Mode, viewModel: CategoriesViewModel) {
        self.mode = mode
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    changeText()
                }
                .foregroundColor(DS.Colors.Theme.grayLight)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Spacer()
                
                LazyVGrid(
                    columns: Array(repeating:
                            .init(.flexible(),
                                  spacing: Drawing.columnsSpacing),
                                   count: Drawing.columnsCount)
                )
                {
                    ForEach(Categories.allCases) { category in
                        Button(action: {
                            if viewModel.categories.contains(category) {
                                viewModel.categories.removeAll { $0 == category }
                            } else {
                                viewModel.categories.append(category)
                            }
                            viewModel.saveCategories()
                        })
                        {
                            HStack(spacing: Drawing.horizontalSpacing) {
                                Spacer()
                                Text(category.image)
                                Text(category.rawValue.localized(language))
                                Spacer()
                            }
                            .foregroundStyle(
                                viewModel.categories.contains(category)
                                ? Color.white
                                : Color.black.opacity(0.6)
                            )
                            .font(.headline.bold())
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .padding(.vertical, Drawing.verticalSpacing)
                            .background(
                                viewModel.categories.contains(category)
                                ? Color.indigo
                                : Color.gray.opacity(0.1))
                            .cornerRadius(Drawing.cornerRadius)
                        }
                    }
                }
                .padding()
            }
            
            Spacer()
            if mode == .onboarding {
                IndigoButton(
                    title: "Choose".localized(language),
                    action:  { viewModel.categoryChosen() }
                    
                )
                .padding()
            }
        }
        .navigationTitle("Categories".localized(language))
    }
    
    private func changeText() -> Text {
        mode == .onboarding
        ? Text("Select some of your favorite topics to let us suggest better news for you.".localized(language))
        : Text("Thousands of articles in each category".localized(language))
    }
}

#Preview {
    NavigationView {
        CategoriesView(mode: .onboarding, viewModel: CategoriesViewModel(coordinator: Coordinator()))
    }
}
