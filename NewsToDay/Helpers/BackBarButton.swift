//
//  BackBarButton.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 08.04.2024.
//

import SwiftUI
import DS

struct BackBarButton: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    private let iconName: String
    private let foregroundColor: Color
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: dismiss.callAsFunction) {
                Image(systemName: iconName)
                    .foregroundColor(foregroundColor)
            }
        }
    }
    
    private init(_ iconName: String, foregroundColor: Color) {
        self.iconName = iconName
        self.foregroundColor = foregroundColor
    }
    
    static func blueArrow() -> BackBarButton {
        BackBarButton("arrow.left", foregroundColor: DS.Colors.Theme.indigoAccent)
    }
}
