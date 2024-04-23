//
//  AuthInputView.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 23.03.2024.
//

import DS
import SwiftUI

struct AuthInputView: View {
    
    enum FocusedField {
        case email
        case password
    }
    
    private enum Drawing {
        static let borderColor = DS.Colors.Theme.indigoAccent
        static let activeBackground = DS.Colors.Theme.whiteAccent
        static let foreground = DS.Colors.Theme.buttonText
        static let background = DS.Colors.Theme.buttonBackground
        static let cornerRadius: CGFloat = 12
    }
    
    @Binding var text: String
    @FocusState private var focusedField: FocusedField?
    var isSecureField: Bool
    
    let imageName: String
    let placeholder: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: imageName)
                    .foregroundColor(focusedField == (isSecureField ? .password : .email) ? Drawing.borderColor : Drawing.foreground)
                    .padding(.leading, 8)
                if isSecureField {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .focused($focusedField, equals: isSecureField ? .password : .email)
            .padding()
            .background(focusedField == (isSecureField ? .password : .email) ? Drawing.activeBackground : Drawing.background)
            .clipShape(RoundedRectangle(cornerRadius: Drawing.cornerRadius))
            .background(
                RoundedRectangle(cornerRadius: Drawing.cornerRadius)
                    .stroke(focusedField == (isSecureField ? .password : .email) ? Drawing.borderColor : Drawing.background, lineWidth: 2)
            )
        }
    }
}

#Preview {
    AuthInputView(text: .constant(""), isSecureField: false, imageName: "envelope.fill", placeholder: "Email Adres")
}


