//
//  TrackerView.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/26/24.
//

import SwiftUI

//include a calendar to see history?
//include a graph to see trends over time?
//fix calculator button sizing and icon (?)

struct TrackerView: View {
    
    //tracks date selected on calendar
    @State var selectedDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    
                    HStack{
                        Spacer()
                        //relocate calculate button
                        NavigationLink{
                            CalculatorView()
                        }
                    label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .font(.headline)
                            .bold()
                            .frame(width: 55, height: 40)
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(30)
                        
                    }
                    .padding(.trailing,50)

                    }
                    
                    Text("Sustainability Tracker")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .bold()
                        .padding()
                    
                                        
                    ScrollView{
                        //Displays calendar
                        DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .tint(.green)
                            .padding(.horizontal)
                        
                    }
                    
                }
                
                
            }
        }
    }
}

//fix rounding of variables with slider
struct CalculatorView: View{
    @State var mealsWithMeat = 0.0
    @State var mealsWithPoultry = 0.0
    @State var plasticBottles = 0.0
    @State var milesDriven = 0.0
    @State var totalEmissions = 0.0
    
    @State private var isEditingMeat = false
    @State private var isEditingPoultry = false
    @State private var isEditingBottles = false
    @State private var isEditingMiles = false
    
    var body: some View {
        
        
        ZStack {
            VStack {
                Text("My Emissions Calculator")
                    .multilineTextAlignment(.leading)
                    .font(.title2)
                    .bold()
                
                Text("On average, each day I...")
                    .bold()
                    .padding()
                HStack {
                    Text("Have \(mealsWithMeat) Meals with Meat")
                        .frame(width:150)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Slider(
                            value: $mealsWithMeat,
                            in: 0...3,
                            step: 1
                        ) {
                            Text("Meals with Meath")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("3")
                        } onEditingChanged: { editing in
                            isEditingMeat = editing
                        }
//                        Text("\(mealsWithMeat)")
//                            .foregroundColor(isEditingMeat ? .gray : .green)
                    }
                    .frame(width: 200)
                }
                HStack {
                    Text("Have \(mealsWithPoultry) Meals with Poultry")
                        .frame(width:150)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Slider(
                            value: $mealsWithPoultry,
                            in: 0...3,
                            step: 1
                        ) {
                            Text("Meals with Poultry")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("3")
                        } onEditingChanged: { editing in
                            isEditingPoultry = editing
                        }
//                        Text("\(mealsWithPoultry)")
//                            .foregroundColor(isEditingPoultry ? .gray : .green)
                    }
                    .frame(width: 200)
                }
                
                HStack {
                    Text("Use \(round(plasticBottles)) Plastic Waterbottles")
                        .multilineTextAlignment(.center)
                        .frame(width:150)
                    
                    VStack {
                        Slider(
                            value: $plasticBottles,
                            in: 0...3,
                            step: 1
                        ) {
                            Text("Plastic Bottles")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("3")
                        } onEditingChanged: { editing in
                            isEditingBottles = editing
                        }
//                        Text("\(plasticBottles)")
//                            .foregroundColor(isEditingBottles ? .gray : .green)
                    }
                    .frame(width: 200)
                }
                HStack {
                    Text("Drive \(milesDriven.rounded(.toNearestOrEven)) Miles")
                        .multilineTextAlignment(.center)
                        .frame(width:150)
                    
                    VStack {
                        Slider(
                            value: $milesDriven,
                            in: 0...30,
                            step: 1
                        ) {
                            Text("Miles Driven")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("30")
                        } onEditingChanged: { editing in
                            isEditingMiles = editing
                        }
//                        Text("\(plasticBottles)")
//                            .foregroundColor(isEditingBottles ? .gray : .green)
                    }
                    .frame(width: 200)
                }
                
//                //button here that calls calculate function
//                    calculateEmissions(meat: mealsWithMeat, poultry: mealsWithPoultry, bottles: plasticBottles, miles: milesDriven, total: totalEmissions)
//                    Text("My weekly emissions are  \(String(totalEmissions * 7)).")
//                    Text("My yearly emissions are \(String(totalEmissions * 365))")
//                        
//                }
            }
        }
        
//    func calculateEmissions(meat: Double, poultry: Double, bottles: Double, miles: Double, total: Double){
//        
//        //beef = 60 kg per 1 kg beef -> 6.0 kg per 100 g
//        //chicken = 1.82 kg per 100 g
//        //bottles = .828 kg
//        //mile = .411 kg
//        
//        total += meat * 6.0
//        total += poultry * 1.82
//        total += bottles * .828
//        total += miles * .411
    }
    
}



#Preview {
    TrackerView()
}
