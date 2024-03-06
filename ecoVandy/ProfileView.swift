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
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        let user = viewModel.user
        VStack{
            // name
            Text("Sydney Leonardi")
                .font(.largeTitle)
                .bold()
                .padding(.top, 10)
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
                    Text(user?.email ?? "")
                        .frame(width:340, height: 50)
                        .background(Color("LightGreen"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color("DarkGreen"))
                        .bold()
                    Text("Year")
                        .font(.title3)
                        .bold()
                    Text(user?.year ?? "")
                        .frame(width:340, height: 50)
                        .background(Color("LightGreen"))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                        .foregroundColor(Color("DarkGreen"))
                        .bold()
                    Text("On/Off Campus")
                        .font(.title3)
                        .bold()
                    Text(viewModel.onOff)
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
        .onAppear(){
            Task{
                do{
                    try await viewModel.loadCurrentUser()
                }catch{
                    print("There is an error :\(error.localizedDescription)")
                }
                
            }
        }
}
    
}

#Preview {
    ProfileView()
}
