//
//  CreateProfileView.swift
//  ecoVandy
//
//  Created by Caroline Dunn on 2/27/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CreateProfileView: View {
    @State var accountEmail: String
    
    @State private var firstName: String = ""
    var firstNameOpacity: Double {
        return firstName.isEmpty ? 1 : 0
    }
    
    @State private var lastName: String = ""
    var lastNameOpacity: Double {
        return lastName.isEmpty ? 1 : 0
    }
    
    @State private var email: String = ""
    var emailOpacity: Double {
        return email.isEmpty ? 1 : 0
    }

    
    var body: some View {
        ZStack{
            VStack{
                Section{
                    Text("Create a Profile")
                        .font(.title)
                }
                .padding(.top, 30)
                Section{
                    Image("ecoVandy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                Section{
                    HStack {
                        Text("First Name:")
                            .frame(maxWidth: 90, alignment: .leading)
                            .padding([.leading], 6)
                            .padding([.top, .bottom], 5)
                            .padding([.trailing], -135)
                            .opacity(firstNameOpacity)
                            .foregroundColor(Color(UIColor.darkGray))
                        // store the entered text in the eventTitle variable
                        TextField(
                            "",
                            text: $firstName)
                    }
                    .background(Color(#colorLiteral(red: 0.5, green: 0.8901960849761963, blue: 0, alpha: 1)))
                    .cornerRadius(5)
                    .frame(width: 325)
                }
                Section{
                    HStack {
                        Text("Last Name:")
                            .frame(maxWidth: 90, alignment: .leading)
                            .padding([.leading], 6)
                            .padding([.top, .bottom], 5)
                            .padding([.trailing], -135)
                            .opacity(lastNameOpacity)
                            .foregroundColor(Color(UIColor.darkGray))
                        // store the entered text in the eventTitle variable
                        TextField(
                            "",
                            text: $lastName)
                    }
                    .background(Color(#colorLiteral(red: 0.5, green: 0.8901960849761963, blue: 0, alpha: 1)))
                    .cornerRadius(5)
                    .frame(width: 325)
                }
                Section{
                    HStack {
                        Text("Vanderbilt Email:")
                            .frame(maxWidth: 130, alignment: .leading)
                            .padding([.leading], 6)
                            .padding([.top, .bottom], 5)
                            .padding([.trailing], -135)
                            .opacity(emailOpacity)
                            .foregroundColor(Color(UIColor.darkGray))
                        // store the entered text in the eventTitle variable
                        TextField(
                            "",
                            text: $email)
                    }
                    .background(Color(#colorLiteral(red: 0.5, green: 0.8901960849761963, blue: 0, alpha: 1)))
                    .cornerRadius(5)
                    .frame(width: 325)
                }
                Section{
                    NavigationLink(destination: HomeView()) {
                        Text("Save Profile")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding([.top, .bottom], 10)
                            .padding([.leading, .trailing], 10)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(UIColor.darkGray))
                    }
                    .simultaneousGesture(TapGesture().onEnded({
                        saveProfileToFirebase()
                    }))
                    .padding([.leading, .trailing], 80)
                    .background(.white)
                    .cornerRadius(6)
                }
            }
        }
    }
    func saveProfileToFirebase(){
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(accountEmail)
        userRef.updateData([
            "email": email,
            "firstName": firstName,
            "firstSignIn": false,
            "lastName": lastName,
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }

    }
}

struct CreateProfile_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView(accountEmail: "test@gmail.com")
    }
}
