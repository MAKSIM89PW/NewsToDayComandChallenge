//
//  IndigoButton.swift
//  NewsToDay
//
//  Created by Максим Самороковский on 23.03.2024.
//

import DS
import SwiftUI

struct IndigoButton: View {
    private enum Drawing {
        static let background = DS.Colors.Theme.indigoAccent
        static let foreground = DS.Colors.Theme.whiteAccent
        static let cornerRadius: CGFloat = 12
    }
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Spacer()
                Text(title)
                Spacer()
            }
            .padding()
            .foregroundStyle(Drawing.foreground)
            .background(Drawing.background)
            .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
        }
    }
}
#Preview {
    IndigoButton(title: "Sign In", action: {})
}
