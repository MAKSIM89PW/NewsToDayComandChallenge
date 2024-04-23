//
//  ProfileView.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 20.03.2024.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("selectedLanguage") private var language = LocalizationManager.shared.language
    
    @ObservedObject var viewModel: ProfileViewModel
    
    @State private var isShowingLanguageScreen = false
    @State private var isShowingTermsConditionsScreen = false
    @State private var isShowingSignOut = false
    
    @State private var showAlert = false
    
    @State var image: Image?
    @State private var inputImage = UIImage(named: "avatar")
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ProfileHeader(
                    userName: viewModel.currentUser?.userName ?? "🫢",
                    email: viewModel.currentUser?.email ?? "d@v.ru",
                    avatar: inputImage ?? UIImage(systemName: "person.fill")!
//                    avatar: viewModel.userPhoto ?? UIImage(systemName: "person.fill")!
                )
                .onTapGesture {
                    showingImagePicker = true
                }
            }
            .padding()
            .onAppear {
                viewModel.updateUserPhoto()
            }
            
            NavigationLink(destination: SettingsScreen(), isActive: $isShowingLanguageScreen) {
                EmptyView()
            }
            .hidden()
            
            CustomButton(
                title: "Settings".localized(language),
                imageName: "chevron.right",
                action: {
                    isShowingLanguageScreen = true
                },
                buttonType: .profile,
                isSelected: false
            )
            .padding()
            Spacer()
            
            NavigationLink(
                destination: TermsConditionsScreen(title: ""),
                isActive: $isShowingTermsConditionsScreen) {
                    EmptyView()
                }
                .hidden()
            
            CustomButton(
                title: "Terms & Conditions".localized(language),
                action: {
                    isShowingTermsConditionsScreen = true
                },
                buttonType: .profile,
                isSelected: false
            )
            .padding()
            
            
            CustomButton(
                title: "Sign Out".localized(language),
                imageName: "rectangle.portrait.and.arrow.right",
                action: {
                    showAlert = true
                },
                buttonType: .profile,
                isSelected: false
            )
            .padding()
            Spacer()
            
        }
        .navigationTitle("Profile".localized(language))
        
        .onChange(of: inputImage) { _ in
            loadImage()

        }
        
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Are you sure you want to go out?".localized(language)),
                primaryButton: .default(Text("Yes".localized(language))) {
                    viewModel.signOut()
                },
                secondaryButton: .cancel(Text("Cancel".localized(language)))
            )
        }
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        viewModel.didChangeProfileImage(inputImage)
    }
}

#Preview  {
    NavigationView {
        ProfileView(viewModel: ProfileViewModel(coordinator: Coordinator()))
    }
}


