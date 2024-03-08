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
    var paperUsed: String
    var plasticBottles: String
    var recycledItems: String
    var showerLength: String
    var singleUseItems: String
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
                   let paperUsedData = data["paperUsed"] as? [String: String],
                   let paperUsedVal = paperUsedData[date],
                   let plasticBottlesData = data["plasticBottles"] as? [String: String],
                   let plasticBottlesVal = plasticBottlesData[date],
                   let recycledItemsData = data["recycledItems"] as? [String: String],
                   let recycledItemsVal = recycledItemsData[date],
                   let showerLengthData = data["showerLength"] as? [String: String],
                   let showerLengthVal = showerLengthData[date],
                   let singleUseItemsData = data["singleUseItems"] as? [String: String],
                   let singleUseItemsVal = singleUseItemsData[date]
                    
                {
                    let habit = Habit(id: userID.lowercased(), name: firstName+lastName, date: date, meatlessMeals: meatlessMealsVal, milesDriven: milesDrivenVal, paperUsed: paperUsedVal, plasticBottles: plasticBottlesVal, recycledItems: recycledItemsVal, showerLength: showerLengthVal, singleUseItems: singleUseItemsVal)
                    return habit
                }else{
                    return Habit(id: "NA", name: "NA", date: "NA", meatlessMeals: "NA", milesDriven: "NA", paperUsed: "NA", plasticBottles: "NA", recycledItems: "NA", showerLength: "NA", singleUseItems: "NA")
                }
            }
        }
    }
    
    func updateHabitData(date: String, id: String, meatlessMeals: String, milesDriven: String, paperUsed: String, plasticBottles: String, recycledItems: String, showerLength: String, singleUseItems: String) {
        
        let habitData1: [String: Any] = ["meatlessMeals": [date: meatlessMeals]]
        
        db.collection("users").document(id).setData(habitData1, merge: true)
        
        
        let habitData2: [String: Any] = ["milesDriven": [date: milesDriven]]
        
        db.collection("users").document(id).setData(habitData2, merge: true)
        
        let habitData3: [String: Any] = ["paperUsed": [date: paperUsed]]
        
        db.collection("users").document(id).setData(habitData3, merge: true)
        
        let habitData4: [String: Any] = ["plasticBottles": [date: plasticBottles]]
        
        db.collection("users").document(id).setData(habitData4, merge: true)
        
        let habitData5: [String: Any] = ["recycledItems": [date: recycledItems]]
        
        db.collection("users").document(id).setData(habitData5, merge: true)
        
        let habitData6: [String: Any] = ["showerLength": [date: showerLength]]
        
        db.collection("users").document(id).setData(habitData6, merge: true)
        
        let habitData7: [String: Any] = ["singleUseItems": [date: singleUseItems]]
        
        db.collection("users").document(id).setData(habitData7, merge: true)
    }
    
    
}
