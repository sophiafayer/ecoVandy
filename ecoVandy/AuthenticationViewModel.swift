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
import SwiftUI
import AuthenticationServices
import CryptoKit

class AuthenticationViewModel: ObservableObject {
    fileprivate var currentNonce: String?
    
    // 1
    enum SignInState {
      case signedIn
      case signedOut
    }

    // 2
    @Published var state: SignInState = .signedOut
    
    func signInWithGoogle() {
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
    func signInWithApple() -> some View {
             return SignInWithAppleButton(.signIn) { request in
                 let nonce = self.randomNonceString()
                 self.currentNonce = nonce
                 request.requestedScopes = [.fullName, .email]
                 request.nonce = self.sha256(nonce)
             } onCompletion: { result in
                 switch result {
                 case .success(let authResults):
                     NotificationManager.instance.requestAuthorization()
                     if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                         guard let nonce = self.currentNonce else {
                           fatalError("Invalid state: A login callback was received, but no login request was sent.")
                         }
                         guard let appleIDToken = appleIDCredential.identityToken else {
                           print("Unable to fetch identity token")
                           return
                         }
                         guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                           print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                           return
                         }
                         let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString,rawNonce: nonce)
                         Auth.auth().signIn(with: credential) { (result, error) in
                             if let user = result?.user {
                                 self.state = .signedIn
                                 NotificationManager.instance.requestAuthorization()
                             }

                         }
                     }
     //                self.state = .signedIn
     //                print("Authorization successful \(authResults)")
                 case .failure(let error):
                     print("Authorization failed: \(error.localizedDescription)")
                 }
             }
             .frame(maxWidth: .infinity)
             .frame(height: 75, alignment: .center)
             .signInWithAppleButtonStyle(.white)
             .cornerRadius(10)
             .shadow(color: .gray, radius: 2, x: 0, y: 2)
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
    
    func randomNonceString(length: Int = 32) -> String {
          precondition(length > 0)
          var randomBytes = [UInt8](repeating: 0, count: length)
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }

          let charset: [Character] =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

          let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
          }

          return String(nonce)
        }
    
    @available(iOS 13, *)
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

