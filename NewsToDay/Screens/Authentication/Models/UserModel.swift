//
//  UserModel.swift
//  NewsToDay
//
//  Created by Максим Нурутдинов on 23.03.2024.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let userName: String
    let email: String
    var userPhoto: String?
}
