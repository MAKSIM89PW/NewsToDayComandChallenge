//
//  RoundButton.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 06.04.2024.
//

import SwiftUI
import DS

struct RoundButton: View {
    let action: () -> Void
    let imageName: String
    
    enum Drawing {
           static let opacity = 0.9
           static let buttonSize: CGFloat = 25
       }
       
       var body: some View {
           Button(action: action) {
               Image(systemName: imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: Drawing.buttonSize, height: Drawing.buttonSize) 
                   .foregroundColor(.white)
                   .padding(8)
                   .background(DS.Colors.Theme.indigoAccent.opacity(Drawing.opacity))
                   .clipShape(Circle())
           }
       }
   }
