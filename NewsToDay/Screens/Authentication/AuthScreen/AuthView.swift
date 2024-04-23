//
//  AuthView.swift
//  NewsToDay
//
//  Created by Келлер Дмитрий on 17.03.2024.
//

import DS
import SwiftUI

struct AuthView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language

    var body: some View {
        ScrollView {
            VStack {
                AuthTitle(title: "I am happy to see you again. You can continue where you left off by logging in".localized(language))
                    .padding()
                VStack(spacing: 20) {
                    AuthInputView(
                        text: $authViewModel.email,
                        isSecureField: false,
                        imageName: "envelope.fill",
                        placeholder: "Email".localized(language)
                    )
                    .autocapitalization(.none)
                    AuthInputView(
                        text: $authViewModel.password,
                        isSecureField: true,
                        imageName: "lock",
                        placeholder: "Password".localized(language)
                    )
                }
                .dismissKeyboardOnTapOutside()
                .padding()
                Spacer()
                IndigoButton(title: "Sign In".localized(language)) {
                    authViewModel.signIn()
                }
                .padding(.top, 25)
                .alert(isPresented: $authViewModel.isPresentError) {
                    Alert(
                        title: Text("Error".localized(language)),
                        message: Text(authViewModel.errorMessage ?? "Unknown error".localized(language)),
                        dismissButton: .default(Text("Ok".localized(language)))
                    )
                }
                .disabled(!authViewModel.formIsValid)
                .opacity(authViewModel.formIsValid ? 1.0 : 0.5)
                .padding()
                Spacer()
                    AuthTextButton(
                        title: "Don't have an account? Sign Up!".localized(language)
                    ) {
                      
                        authViewModel.userRegister()
                    }
                    .padding(.top, 243)
                }
                
            .navigationTitle("Welcome Back".localized(language))
        }
        }
    }


#Preview {
    NavigationView {
        AuthView(authViewModel: AuthViewModel(coordinator: Coordinator()))
    }
}


