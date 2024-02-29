//
//  AuthenticationViewModel.swift
//  ecoVandy
//
//  Created by Caroline Dunn on 2/27/24.
//
// This file is used to help implement signing in with Google SSO.

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    // 1
    enum SignInState {
      case signedIn
      case signedOut
    }

    // 2
    @Published var state: SignInState = .signedOut
    
    func signIn() {
      // 1
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
      } else {
        // 2
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // 3
        let configuration = GIDConfiguration(clientID: clientID)
        
        // 4
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

        // 5
          GIDSignIn.sharedInstance.configuration = configuration
          GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) {
              [unowned self] user, error in
              authenticateUser(for: user?.user, with: error)
          }
      }
    }
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
      // 1
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      // 2
        
        guard let idToken = user?.idToken, let accessToken = user?.accessToken else { return }
      
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
      
      // 3
      Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          self.state = .signedIn
        }
      }
    }
}

