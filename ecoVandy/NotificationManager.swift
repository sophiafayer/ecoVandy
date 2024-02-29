//
//  NotificationManager.swift
//  ecoVandy
//
//  Created by Caroline Dunn on 2/27/24.
// This file helps implement notification pop ups within our application.

import Foundation
import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options){ (success, error) in
            if let error = error{
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
}
