//
//  ViewManager.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 3/4/24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseFirestore

//How to call:
//@ObservedObject var vm = ViewModel()
//var body: some View{ ...
//self.vm.fetchData()
//...
//}

//or
//@ObservedObject var vm = ViewModel()
//var body: some View{ ...}
//.onAppear{self.vm.fetchData()}

struct UserProfile: Identifiable, Equatable {
    var id: String
    var name: String
    var year: String
    var onCampus: Bool
}

class ViewModel: ObservableObject{
    
    @Published var users = [UserProfile]()
    
    private var db = Firestore.firestore()
    
    //read data
    func fetchData(){
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.users = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                //verify correct data is pulled for each user
            if let userID = data["email"] as? String,
            let name = data["name"] as? String,
            let year = data["year"] as? String,
            let onCampus = data["onCampus"] as? Bool {
                let user = UserProfile(id: userID, name: name, year: year, onCampus: onCampus)
            return user
            }else{
                return UserProfile(id: "NA", name: "NA", year: "NA", onCampus: false)
            }
            }
        }
    }
    
    //write data
}
