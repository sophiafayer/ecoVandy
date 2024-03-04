//
//  TrackerViewManager.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/29/24.
//

import SwiftUI
import Foundation
import FirebaseCore
import FirebaseFirestore

struct Habit: Identifiable, Equatable {
    var id: String
    var name: String
    var date: String
    var habit: String
    var habitVal: String
}

class TrackerViewModel: ObservableObject{
    
    @Published var habits = [Habit]()
    
    private var db = Firestore.firestore()
    
    func fetchData(id: String, date: String, habitType: String){
        //pull all users
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.habits = documents.map { (QueryDocumentSnapshot) in
            let data = QueryDocumentSnapshot.data()
                //verify correct data is pulled for each user
            if let userID = data["email"] as? String,
            let name = data["name"] as? String,
            let habitData = data[habitType] as? [String: Any]
                //,
            //let habitVal = habitData[date] as? String
                {
                let habit = Habit(id: userID.lowercased(), name: name, date: date, habit: habitType, habitVal: "NA")
            return habit
            }else{
                //send match data to MatchedListView
                return Habit(id: "NA", name: "NA", date: "NA", habit: "NA", habitVal: "NA")
            }
            }
        }
    }
    
}

//class TrackerViewModel: ObservableObject {
//    
//    @Published var habits = [Habit]()
//    
//    private var db = Firestore.firestore()
//    
//    func fetchHabit(id: String, date: String, habit: String){
//        
//        //note: try adding / before users if preview crashses
//        let path = "users/caroline.a.dunn@vanderbilt.edu"
//        //"users/" + id
//        
//        db.collection(path).addSnapshotListener{ (querySnapshot, error) in
//            guard let docs = querySnapshot?.documents else {
//                print("Documents not found")
//                return
//            }
//            print("got here")
//            
//            //read data from db
//            self.habits = docs.map {QueryDocumentSnapshot -> Habit in
//                
//                let data = QueryDocumentSnapshot.data()
//                let id = data["email"] as? String ?? ""
//                let first = data["firstName"] as? String ?? ""
//                let last = data["lastName"] as? String ?? ""
//                //let habitMap = data[habit] as? [String:Any] ?? nil
//                //let habitVal = habitMap?[date] as? String ?? ""
//                let name = first + last
////                let habitVal = ((HashMap<String, Object>) document.getData().get(habit)).get(date).toString
//                
//                return Habit(id: id.lowercased(), name: name, date: date, habit: habit)
//                //return Habit(id: id.lowercased(), name: name, date: date, habit: habit, habitVal: habitVal)
//            }
//        }
//        
//    }
//    
//    //write to db
//    //func trackHabit {}
//    
//    
//    //write to db
//    //func deleteHabit {}
//}
