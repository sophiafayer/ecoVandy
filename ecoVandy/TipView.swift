//
//  TipView.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/1/24.
//

import SwiftUI


struct TipView: View {
    
    var category = "food"
    var imageName = ""
    
    var body: some View {
        ZStack{
            Color("LightGreen")
                .ignoresSafeArea()
            VStack{
                Text("Sustainable Tip of the Day!")
                    .font(.title)
                    .foregroundStyle(Color("DarkGreen"))
                    .bold()
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                Text(getTodaysDate())
                    .font(.title2)
                    .foregroundColor(Color("DarkGreen"))
                    .padding(.bottom, 30)
                Image(systemName: "carrot")
                    .font(.largeTitle)
                    .foregroundColor(Color("DarkGreen"))
                Text("Visit Your Local Farmer's Market!")
                    .font(.title3)
                    .frame(width: 330, height: 100)
                    .foregroundColor(Color("DarkGreen"))
                HStack{
                    Text("Why?")
                        .bold()
                        .font(.title)
                        .frame(width: 100, height: 0)
                        .foregroundColor(Color("DarkGreen"))
                        .padding(.leading, 10)
                        .padding (.top, 10)
                    Spacer()
                }

                Text("Support small businesses & get fresh groceries all while helping reduce transportation emissions by shopping local")
                    .font(.title3)
                    .padding(.top, 10)
                    .frame(width: 300, height: 125)
                    .foregroundColor(Color("DarkGreen"))
                Spacer()
                
            }
        }
    }
    
    // getting the current date
    func getTodaysDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d'\(daySuffix(from: Date()))', yyyy"
        return dateFormatter.string(from: Date())
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
    
    mutating func getIcon() -> String {
        if(category == "food")
        {
            imageName = "carrot"
        }
        else if (category == "water")
        {
            imageName = "drop"
        }
        else if (category == "reusable")
        {
            imageName = "arrow.3.trianglepath"
        }
        else if (category == "energy")
        {
            imageName = "lightbulb.max"
        }
        else if (category == "education"){
            imageName = "list.bullet.clipboard"
        }
        else {
            //imageName =
        }
        
        return imageName
    }
    // Randomize the icons based on the categories)
    // Randomize the tips
    //
    
    
}

#Preview {
    TipView()
}
