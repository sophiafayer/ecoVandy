//
//  HomeView.swift
//  SWEGroup12-Tennis
//
//  Created by Sophia Fayer on 10/22/23.
//
import UIKit


import SwiftUI
let uiColor = UIColor.red
let swiftUIColor = Color(uiColor)

struct NavView: View {
    var body: some View {
        TabView{
            
            HomeView()
                .tabItem { Label("Calendar", systemImage: "house.fill") }
            

            TipView()
                .tabItem { Label("Tip", systemImage: "lightbulb.fill") }
            

            TrackerView()
                .tabItem { Label("Tracker", systemImage: "tree.fill")}
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle") }
        }
        .accentColor(swiftUIColor)
    }
}



#Preview {
    NavView()
}


