//
//  RegistrationView.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 23.03.2024.
//

import DS
import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject var viewModel: RegistrationViewModel
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 20) {
                    AuthTitle(title: "Hello, I guess you are new around here. You can start using the application after sign up.".localized(language))
                    
                    AuthInputView(
                        text: $viewModel.userName,
                        isSecureField: false,
                        imageName: "person.fill",
                        placeholder: "Username".localized(language)
                    )
                    
                    AuthInputView(
                        text: $viewModel.email,
                        isSecureField: false,
                        imageName: "envelope.fill",
                        placeholder: "Email".localized(language)
                    )
                    
                    .autocapitalization(.none)
                    AuthInputView(
                        text: $viewModel.password,
                        isSecureField: true,
                        imageName: "exclamationmark.lock.fill",
                        placeholder: "Password".localized(language)
                    )
                    ZStack(alignment: .trailing) {
                        AuthInputView(
                            text: $viewModel.repeatPassword,
                            isSecureField: true,
                            imageName: "exclamationmark.lock.fill",
                            placeholder: "Repeat Password".localized(language))
                        
                        Image(systemName: viewModel.passwordCheck ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(viewModel.passwordCheck ? .green : .red)
                            .opacity(!viewModel.repeatPassword.isEmpty ? 1 : 0)
                            .padding(.trailing)
                    }
                }
            }
            .padding()
            IndigoButton(title: "Sign Up".localized(language)) {
                viewModel.createUsers()
                viewModel.userRegistered()
            }
            .padding(.horizontal)
            .alert(isPresented: $viewModel.isPresentError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("Ok"))
                )
            }
            .disabled(!viewModel.formIsValid)
            .opacity(viewModel.formIsValid ? 1.0 : 0.5)
            Spacer()
            AuthTextButton(title: "Already have an account? Sign In!".localized(language)) {
                viewModel.userRegistered()
            }
            .padding(.top, 175)
        }
        .dismissKeyboardOnTapOutside()
        .navigationTitle("Welcome to NewsToDay".localized(language))
    }
}


#Preview {
    NavigationView {
        RegistrationView(viewModel: RegistrationViewModel(coordinator: Coordinator()))
        
    }
}

