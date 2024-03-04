//
//  ProfileView.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/4/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct ProfileView: View {
    
    var body: some View {
        VStack{
            // name
            Text("Sydney Leonardi")
                .font(.largeTitle)
                .bold()
                .padding(.top, 10)
                .foregroundColor(Color("DarkGreen"))
                .padding(.bottom, 5)
            // icon
            Image(systemName: "waterbottle")
                .foregroundColor(Color("DarkGreen"))
                .bold()
                .font(.title)
                .padding(.bottom, 5)
            HStack{
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.title3)
                        .bold()
                    Text("sydney.j.leonardi@vanderbilt.edu")
                        .frame(width:340, height: 50)
                        .background(Color("LightGreen"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color("DarkGreen"))
                        .bold()
                    Text("Grade")
                        .font(.title3)
                        .bold()
                    Text("Senior")
                        .frame(width:340, height: 50)
                        .background(Color("LightGreen"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color("DarkGreen"))
                        .bold()
                    Text("On/Off Campus")
                        .font(.title3)
                        .bold()
                    Text("Off")
                        .frame(width:340, height: 50)
                        .background(Color("LightGreen"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color("DarkGreen"))
                        .bold()
                }
                .padding(.leading, 25)
                Spacer()
            }
            Spacer()
            
        }
}
    
}

#Preview {
    ProfileView()
}
