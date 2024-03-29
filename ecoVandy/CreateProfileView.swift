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

    // Set to value, but it will get changed
    enum Grade: String, CaseIterable, Identifiable {
        case freshman, sophomore, junior, senior
        var id: Self { self }
    }
    @State private var grade: Grade = .freshman
    
    @State private var onCampus: OnCampus = .yes
    enum OnCampus: String, CaseIterable, Identifiable {
        case yes, no
        var id: Self { self }
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
                            .foregroundColor(Color("DarkGreen"))
                        // store the entered text in the  variable
                        TextField(
                            "",
                            text: $firstName)
                    }
                    .background(Color("LightGreen"))
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
                            .foregroundColor(Color("DarkGreen"))
                        // store the entered text in the  variable
                        TextField(
                            "",
                            text: $lastName)
                    }
                    .background(Color("LightGreen"))
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
                            .foregroundColor(Color("DarkGreen"))
                        // store the entered text in the  variable
                        TextField(
                            "",
                            text: $email)
                    }
                    .background(Color("LightGreen"))
                    .cornerRadius(5)
                    .frame(width: 325)
                }
                Section{
                    HStack{
                        Text("Grade:")
                            .padding([.leading], 6)
                            .padding([.top, .bottom], 5)
                            .foregroundColor(Color("DarkGreen"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("grade:", selection: $grade) {
                            Text("Freshman").tag(Grade.freshman)
                            Text("Sophomore").tag(Grade.sophomore)
                            Text("Junior").tag(Grade.junior)
                            Text("Senior").tag(Grade.senior)
                        }
                    }
                    .background(Color("LightGreen"))
                    .cornerRadius(5)
                    .frame(width: 325)
                }
                Section{
                    HStack{
                        Text("On Campus:")
                            .padding([.leading], 6)
                            .padding([.top, .bottom], 5)
                            .foregroundColor(Color("DarkGreen"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Picker("On Campus:", selection: $onCampus) {
                            Text("Yes").tag(OnCampus.yes)
                            Text("No").tag(OnCampus.no)
                        }
                    }
                    .background(Color("LightGreen"))
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
        let userGrade = grade.rawValue
        
        let userRef = db.collection("users").document(accountEmail)
        userRef.updateData([
            "email": email,
            "firstName": firstName,
            "firstSignIn": false,
            "lastName": lastName,
            "onCampus": onCampus == OnCampus.yes ? true : false,
            "year": userGrade
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
