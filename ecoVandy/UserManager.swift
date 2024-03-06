//
//  UserManager.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 3/4/24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


struct DBUser {
    var email: String
    var firstName: String
    var lastName: String
    var year: String
    var onCampus: Bool
}

enum UserDataError: Error{
    case dataNotFound
}

enum UserFetchError: Error{
    case noAuthenticatedUser
}

final class UserManager{
    static let shared = UserManager()
    private var db = Firestore.firestore()
    
    private init() {
    }
    
    func fetchUser(email: String) async throws -> DBUser {
        let snapshot = try await db.collection("users").document(email).getDocument()
        guard let data = snapshot.data(), let email = data["email"] as? String else {
            throw UserDataError.dataNotFound
        }
        
        let firstName = data["firstName"] as? String ?? ""
        let lastName = data["lastName"] as? String ?? ""
        let year = data["year"] as? String ?? ""
        let onCampus = data["onCampus"] as? Bool ?? false
        
        return DBUser(email:email, firstName: firstName, lastName: lastName, year: year, onCampus: onCampus)
    }
    
}

final class UserViewModel: ObservableObject{
    @Published private(set) var user: DBUser?
    @Published var onOff = ""
    
    // add some error functionality into this
    func loadCurrentUser() async throws {
        guard let authUser = Auth.auth().currentUser else{
            throw UserFetchError.noAuthenticatedUser
        }
        self.user = try await UserManager.shared.fetchUser(email:authUser.email ?? "")
        if user?.onCampus == false
        {
            onOff = "Off"
        }else {
            onOff = "On"
        }
    }

}
