//
//  VerticalNewsCollection.swift
//  NewsToDay
//
//  Created by Илья Шаповалов on 30.03.2024.
//

import SwiftUI

struct VerticalNewsCollection: View {
    let newsState: MainDomainReducer.State.NewsState
    
    var body: some View {
        switch newsState {
        case .empty:
            EmptyView()
            
        case .loading:
            ProgressView()
            
        case .success(let news):
            VerticalRecommendedSection(item: news)
            
        case .error(let networkError):
            Text(networkError.localizedDescription)
        }
    }
}

#Preview {
    VerticalNewsCollection(newsState: .empty)
}
