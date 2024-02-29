//
//  TrackerViewManager.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/29/24.
//

import Foundation
import FirebaseFirestore

//keep read/write functions below
//swap with Caroline's view Model to minimize repetition
//swap ID in path with dynamic var

struct Habit: Identifiable, Equatable {
    var id: String
    var user: String
    var date: String
    var habit: String
    var habitVal: String

    
    //insert more habits we're tracking
}


// Using View Model Architecture

class TrackerViewModel: ObservableObject {
    @Published var habits = [Habit]()
    
    private var db = Firestore.firestore()
    
    //grab tracker data from firestore db
    func fetchHabit(id: String, habit: String, date: String){
        
        let path = "users/" + id + "/tracker" + habit + "/" + date
        
        db.collection(path).addSnapshotListener {
            (QuerySnapshot,error) in
            guard let docs1 = QuerySnapshot?.documents else {                print("Documents not found") //handles db error
                
                return
            }
            
            //read data from firebase for Habit objects
            
            self.habits = docs1.map{
                QueryDocumentSnapshot -> Habit in
                let data = QueryDocumentSnapshot.data()
                //let id = "ypfTAHk2RRwuccNKRYi3" //dynamic
                let first = data["first"] as? String ?? ""
                let last = data["last"] as? String ?? ""
                let habitVal = data[date] as? String ?? ""
                
                return Habit(id: "ypfTAHk2RRwuccNKRYi3", user: first+last, date: date, habit: habit, habitVal: habitVal)
                
            }
            
        }
    }
}
