//
//  TipManager.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/4/24.
//

import Foundation
import FirebaseFirestore

struct Tip: Identifiable, Codable
{
    var id: String
    var category:String
    var tip: String
    var explanation: String
}

enum TipDataError: Error{
    case dataNotFound
}

final class TipManager {
    static let shared = TipManager()
    private init() {
        
    }
    
    private var db = Firestore.firestore()
    
    func fetchTip() async throws -> Tip {
        let randomDocId = Int.random(in: 1...5)
        let docId = String(randomDocId)
        
        let snapshot = try await db.collection("tips").document(docId).getDocument()
        guard let data = snapshot.data(), let _ = data["category"] as? String else{
            throw TipDataError.dataNotFound
        }
        
        let category = data["category"] as? String ?? ""
        let tip = data["tip"] as? String ?? ""
        let explanation = data["explanation"] as? String ?? ""
        
        return Tip(id: docId, category: category, tip: tip, explanation: explanation)
        
    }
    
}


class TipViewModel: ObservableObject {
    @Published private(set) var sustainableTip: Tip? = nil
    @Published var imageName = ""
    @Published var date = "" 
    
    
    // loadTip 
    func loadTip() async throws {
        self.sustainableTip = try await TipManager.shared.fetchTip()
        getIcon()
    }
   
    // Getting icon
    func getIcon() -> String {
        if(sustainableTip?.category == "food")
        {
            imageName = "carrot"
        }
        else if (sustainableTip?.category == "water")
        {
            imageName = "drop"
        }
        else if (sustainableTip?.category == "reusable")
        {
            imageName = "arrow.3.trianglepath"
        }
        else if (sustainableTip?.category == "energy")
        {
            imageName = "lightbulb.max"
        }
        else if (sustainableTip?.category == "education"){
            imageName = "list.bullet.clipboard"
        }
        else {
            imageName = "tree"
        }
        
        return imageName
    }
    
    // getting the current date
    func getTodaysDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d'\(daySuffix(from: Date()))', yyyy"
        date = dateFormatter.string(from: Date())
    }
    
    private func daySuffix(from date: Date) -> String {
            let calendar = Calendar.current
            let dayOfMonth = calendar.component(.day, from: date)
            
            switch dayOfMonth {
            case 1, 21, 31: return "st"
            case 2, 22: return "nd"
            case 3, 23: return "rd"
            default: return "th"
            }
    }

        
}
