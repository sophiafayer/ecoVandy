//
//  MainView.swift
//  ecoVandy
//
//  Created by Kathleen Katchis on 3/26/24.
//

import SwiftUI
import Charts
struct DailyValue: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}

let weeklyData = [
    DailyValue(day: "Mon", value: 1),
    DailyValue(day: "Tues", value: 2),
    DailyValue(day: "Wed", value: 3),
    DailyValue(day: "Thurs", value: 4),
    DailyValue(day: "Fri", value: 5),
    DailyValue(day: "Sat", value: 8),
    DailyValue(day: "Sun", value: 10)
]

struct BarChartView: View {
    var data: [DailyValue]

    var body: some View {
        Chart(data) { item in
            BarMark(
                x: .value("Day", item.day),
                y: .value("Value", item.value)
            )
        }
    }
}

struct MainView: View {
    var body: some View {
        
        VStack {
            Text("Welcome back, [Your Name]!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Text("Weekly Values")
                .font(.title)
                .padding()

            // Pass `weeklyData` to `BarChartView`
            BarChartView(data: weeklyData)
                .frame(width: 300, height: 200)
        }
    }
}


#Preview {
    MainView()
}
