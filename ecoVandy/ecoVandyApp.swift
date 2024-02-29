//
//  ecoVandyApp.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/14/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
}

@main
struct ecoVandyApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Login().environmentObject(AuthenticationViewModel())
            }
        }
    }
}


