//
//  View + Extension.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 30.03.2024.
//

import SwiftUI

struct DismissKeyboardOnTapOutside: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

extension View {
    func dismissKeyboardOnTapOutside() -> some View {
        self.modifier(DismissKeyboardOnTapOutside())
    }
}
