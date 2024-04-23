//
//  AuthManagerWithFirebase.swift
//  NewsToDay
//
//  Created by Максим Самороковский on 28.03.2024.
//

import Foundation
import Firebase
import FirebaseFirestore

final class AuthManagerWithFirebase {
    public static let shared = AuthManagerWithFirebase()
    
    var userSession: FirebaseAuth.User?
    var currentUser: UserModel?
    
    private init() {}
    
    func signIn(withEmail email: String, password: String) async throws -> FirebaseAuth.User {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
        await MainActor.run {
                self.userSession = result.user
            }
            return result.user
    }

    func createUser(email: String, password: String, userName: String) async throws -> FirebaseAuth.User {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = UserModel(id: result.user.uid, userName: userName, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            return result.user
    }
    
    func signOut() async throws {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: UserModel.self)
    }
}

