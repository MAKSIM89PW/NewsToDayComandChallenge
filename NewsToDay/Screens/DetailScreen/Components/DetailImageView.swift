//
//  DetailImageView.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 06.04.2024.
//

import SwiftUI
import DS
import NetworkManager

struct DetailImageView: View {
    @State var isOpenURL: Bool = false
    
    let imageUrl: String
    let category: String
    let title: String
    let creator: String
    let action: () -> Void
    
    private enum Drawing {
        static let imageHeightRatio: CGFloat = 2.93
        static let cornerRadius: CGFloat = 16
        static let padding: CGFloat = 16
        static let opacity = 0.7
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            AsyncImageView(imageUrl) { Image in
                Image
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea()
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height / Drawing.imageHeightRatio
            )
            
            VStack {
                HStack {
                    Text(category)
                        .font(DS.Fonts.Inter16.semiBold600)
                        .foregroundStyle(DS.Colors.Theme.whiteAccent)
                        .padding(.vertical, Drawing.padding)
                        .padding(.horizontal, Drawing.padding)
                        .background(DS.Colors.Theme.indigoAccent)
                        .cornerRadius(Drawing.cornerRadius)
                    Spacer()
                }
                .padding()
                
                VStack {
                    HStack {
                        Text(title)
                            .font(DS.Fonts.Inter20.bold700)
                            .foregroundStyle(DS.Colors.Theme.whiteAccent)
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Author: ")
                            .font(DS.Fonts.Inter14.regular400)
                            .foregroundStyle(DS.Colors.Theme.grayLight)
                        Text(creator)
                            .font(DS.Fonts.Inter16.semiBold600)
                            .foregroundStyle(DS.Colors.Theme.grayLight)
                        
                        Spacer()
                    }
                    .padding()
                }
                .background(.ultraThinMaterial.opacity(Drawing.opacity))
            }
        }
    }
}

#Preview {
    DetailImageView(
        isOpenURL: false,
        imageUrl: NewsResults.preview.imageUrl ?? .init(),
        category: NewsResults.preview.category?.first ?? .init(),
        title: NewsResults.preview.title ?? .init(),
        creator: NewsResults.preview.creator?.first ?? .init(), 
        action: {}
    )
}
