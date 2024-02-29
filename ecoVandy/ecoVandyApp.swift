//
//  ecoVandyApp.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/14/24.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
      return true
  }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        var handled: Bool

          handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
          }
        // If not handled by this app, return false.
        return false
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
                    .onOpenURL { url in
                              GIDSignIn.sharedInstance.handle(url)
                    }
            }
        }
    }
}


