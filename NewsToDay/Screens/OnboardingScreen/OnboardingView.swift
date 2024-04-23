//
//  OnboardingView.swift
//  NewsToDay
//
//  Created by dsm 5e on 18.03.2024.
//

import SwiftUI

struct OnboardingView: View {

    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    @ObservedObject var viewModel: OnboardingViewModel
    
    let bounds = UIScreen.main.bounds
    let lastPage = OnboardingPage.pages.count - 1
    let page = OnboardingPage.pages
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    viewModel.onboardingCompleted()
                } label: {
                    Text("Skip".localized(language))
                        .foregroundColor(Drawing.grayColor)
                }
                .padding()
            }
            
            TabView(selection: $viewModel.currentPage) {
                ForEach(0..<page.count, id: \.self) { index in
                    VStack {
                        Image(page[index].image)
                            .resizable()
                            .frame(width: bounds.width * Drawing.imageWidth, height: bounds.height * Drawing.imageHeight)
                            .cornerRadius(Drawing.imageCornerRadius)
                        Spacer()
                        Text(page[index].title)
                            .font(.title)
                        Text(page[index].description)
                            .font(.title3.weight(.light))
                            .foregroundStyle(Drawing.grayColor)
                            .multilineTextAlignment(.center)
                            .padding()
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach(0..<page.count, id: \.self) { index in
                    if index == viewModel.currentPage {
                        Rectangle()
                            .frame(width: Drawing.rectSize, height: Drawing.dotSize)
                            .cornerRadius(Drawing.dotSize / 2)
                            .foregroundColor(Drawing.indigoAccentColor)
                    } else {
                        Circle()
                            .frame(width: Drawing.dotSize, height: Drawing.dotSize)
                            .foregroundColor(Drawing.grayColor)
                    }
                }
            }
            .frame(height: Drawing.dotSize)
            .padding(Drawing.dotSpacing)
            
            IndigoButton(
                title: viewModel.currentPage < lastPage
                ? "Next".localized(language)
                : "Open".localized(language)
            )
            {
                viewModel.currentPage < lastPage
                ? viewModel.goToNextPage()
                : viewModel.onboardingCompleted()
            
            }
            .padding()
        }
        .animation(.easeInOut, value: viewModel.currentPage)
    }
    
    enum Drawing {
        static let imageWidth: CGFloat = 0.7
        static let imageHeight: CGFloat = 0.4
        static let imageCornerRadius: CGFloat = 12
        static let dotSize: CGFloat = 10
        static let rectSize: CGFloat = 20
        static let dotSpacing: CGFloat = 10
        static let buttonCornerRadius: CGFloat = 15
        static let buttonPadding: CGFloat = 16
        static let indigoAccentColor = Color.indigo
        static let grayColor = Color.gray
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel(coordinator: Coordinator()))
        
}
