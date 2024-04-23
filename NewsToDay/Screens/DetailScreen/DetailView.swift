//
//  DetailView.swift
//  NewsToDay
//
//  Created by dsm 5e on 17.03.2024.
//

import SwiftUI
import DS
import NetworkManager


struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var isOpenURL: Bool = false
    
    let item: NewsResults
    let isBookmark: Bool
    let action: () -> Void
    
    var body: some View {
        VStack {
            DetailImageView(
                isOpenURL: isOpenURL,
                imageUrl: item.imageUrl ?? "",
                category: item.category?.first ?? "",
                title: item.title ?? "",
                creator: item.creator?.joined(separator: ", ") ?? "",
                action: action
            )
            
            HStack {
                Text("Results")
                    .font(DS.Fonts.Inter16.semiBold600)
                Spacer()
            }
            .padding(12)
            
            ScrollView {
                Text(item.description ?? "")
                    .foregroundStyle(DS.Colors.Theme.secondaryText)
                    .font(DS.Fonts.Inter16.regular400)
            }
            .padding(.horizontal, 10)
            
        }
        
        .sheet(isPresented: $isOpenURL, content: {
            if let link = item.link, 
                let url = URL(string: link) {
                  SafariView(url: url)
                      .edgesIgnoringSafeArea(.all)
              }
        })
        
        .toolbar {
                ToolbarView(
                    isOpenURL: $isOpenURL,
                    isBookmark: isBookmark,
                    readAction: action, 
                    shareAction: share
                )
        }
        .navigationBarBackButtonHidden()
    }
    
    private func share() {
        guard let url = item.link else {
            return
        }
        let activityView = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        
        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
        }
    }
}

#Preview {
    NavigationView {
        DetailView(item: NewsResults.preview, isBookmark: true, action: {})
    }
}
