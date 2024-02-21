//
//  HomeView.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/21/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            
            HomePageView()
                .tabItem { Label("Home", systemImage: "house.fill") }
            
            TrackerView()
                .tabItem { Label("Tracker", systemImage: "list.number") }
            
            TipView()
                .tabItem { Label("Tips", systemImage: "globe.americas.fill") }
            
            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.circle")}
        }
        //.accentColor(CustomColor.myColor)
    }
}

struct HomePageView: View {
    var body: some View {
        VStack {
            Text("Home page here")
        }
        .padding()
    }
}
struct TrackerView: View {
    var body: some View {
        VStack {
            Text("Tracker page here")
        }
        .padding()
    }
}
struct TipView: View {
    var body: some View {
        VStack {
            Text("Tip page here")
        }
        .padding()
    }
}
struct ProfileView: View {
    var body: some View {
        VStack {
            Text("Profile page here")
        }
        .padding()
    }
}


          


#Preview {
    HomeView()
}
