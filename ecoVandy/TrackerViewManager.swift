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

//add var for all habits and habit Vals
struct Habit: Identifiable, Equatable {
    var id: String
    var name: String
    var date: String
    var meatlessMeals: String
    var milesDriven: String
    var plasticBottles: String
}

//add checks and balances - if date
class TrackerViewModel: ObservableObject{
    
    @Published var habits = [Habit]()
    
    let habitTypes = ["meatlessMeals", "milesDriven"] //, "bottlesUsed"]
    
    private var db = Firestore.firestore()
    
    func fetchHabitData(date: String){
        db.collection("users").addSnapshotListener{ (QuerySnapshot, error) in guard let documents = QuerySnapshot?.documents else {
            print("No Documents")
            return
        }
            
            self.habits = documents.map { (QueryDocumentSnapshot) in
                let data = QueryDocumentSnapshot.data()
                //verify correct data is pulled for each user
                if let userID = data["email"] as? String,
                   let firstName = data["firstName"] as? String,
                   let lastName = data["lastName"] as? String,
                   let meatlessMealsData = data["meatlessMeals"] as? [String: String],
                   let meatlessMealsVal = meatlessMealsData[date],
                   let milesDrivenData = data["milesDriven"] as? [String: String],
                   let milesDrivenVal = milesDrivenData[date],
                   let bottlesUsedData = data["plasticBottles"] as? [String: String],
                   let bottlesUsedVal = bottlesUsedData[date]{
                    let habit = Habit(id: userID.lowercased(), name: firstName+lastName, date: date, meatlessMeals: meatlessMealsVal, milesDriven: milesDrivenVal, plasticBottles: bottlesUsedVal)
                    return habit
                }else{
                    return Habit(id: "NA", name: "NA", date: "NA", meatlessMeals: "NA", milesDriven: "NA", plasticBottles: "NA")
                }
            }
        }
    }
    
    func updateHabitData(date: String, id: String, meatlessMeals: String, milesDriven: String, plasticBottles: String) {
        
        let habitData1: [String: Any] = ["meatlessMeals": [date: meatlessMeals]]
        
        db.collection("users").document(id).setData(habitData1, merge: true)
        
        let habitData2: [String: Any] = ["milesDriven": [date: milesDriven]]
        
        db.collection("users").document(id).setData(habitData2, merge: true)
        
        let habitData3: [String: Any] = ["plasticBottles": [date: plasticBottles]]
        
        db.collection("users").document(id).setData(habitData3, merge: true)
    }

        //                db.collection("users").document(userID).set(
        //                    {habit: {date: habitVal}},
        //                    {merge: true}
        
                
                //        let docRef = db.collection("users").document(userID)
                //
                //        docRef.getDocument { (document, error) in
                //            if let document = document, document.exists {
                //                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                //                print("Document data: \(dataDescription)")
                //            } else {
                //                print("Document does not exist")
                //            }
                //        }
            }
        
        //        {error in
        //            if let error = error{
        //                print("Error updating document :\(error)") //handle db writing error
        //            }
        //            else{
        //                print("updated document") //successful write to db
        //            }
        //        }
        //   }
        


