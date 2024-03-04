//
//  UserLoginView.swift
//  ecoVandy
//
//  Created by Caroline Dunn on 2/27/24.
//

import Foundation
import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift


struct Login: View {
    
    //Our database
    let db = Firestore.firestore()
    
    
    //Indicates whether it's the first time that the user has signed in, which
    //means that they need to create a profile
    @State var firstSignIn = true
    
    @State var loading = true
    
    //Makes data availible to child views
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    //Sets background color
    
    var body: some View {
       switch viewModel.state{
        // If the user is not signed in yet
        case .signedOut:
                    //Displays the login button
                    VStack(spacing: 30) {
                        //Launches the signIn() function when the button is pressed,
                        // which allows the user to sign in with Google
                        Button(action: {
                            NotificationManager.instance.requestAuthorization()
                            viewModel.signInWithGoogle()
                        }){
                            Text("Sign in with")
                                .foregroundColor(.black)
                                .font(.largeTitle)
                            Image("google_logo")
                                .resizable()
                                .frame(width: 45, height: 45)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 2, x: 0, y: 2))
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .font(.title)
                        viewModel.signInWithApple()
                    }
                    .padding()
        
        //If the user is signed in but doesn't have a record in the database,
        //adds their record to the database
        case .signedIn :
            if Auth.auth().currentUser != nil {
                if let user = Auth.auth().currentUser {
                    addRecord(user: user)
                }
            }
        }
    }
    func addRecord (user: User?) -> some View {
        let queue = DispatchQueue(label: "com.app.queue")
        queue.sync {
            //If the user is already in the database, sets the firstSignIn
            // variable to the values from the database
            let userReference = db.collection("users").document(user!.email!)
            userReference.getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    firstSignIn = data?["firstSignIn"] as! Bool
                }
                //Adds the user information to the users collection in the database
                else {
                    db.collection("users").document(user!.email!).setData([
                        "firstName": "",
                        "lastName": "",
                        "email": user!.email!,
                        "firstSignIn": true
                    ])
                    firstSignIn = true
                }
                loading = false
            }
        }
        
        if loading{
            return AnyView(Loading())
                .preferredColorScheme(.light)
        }
        else if firstSignIn{
            return AnyView(CreateProfileView(accountEmail: user!.email!))
                .preferredColorScheme(.light)
        }
        //If the user is not an admin, displays the Member Home view
        else{
            return AnyView(HomeView())
                .preferredColorScheme(.light)
        }
    }
}

//This provides a preview to developers who are editing this file in Xcode
struct UserLoginView_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(AuthenticationViewModel())
            .onOpenURL { url in
                      GIDSignIn.sharedInstance.handle(url)
                    }
    }
}
