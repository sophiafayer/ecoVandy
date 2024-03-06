//
//  TrackerView.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/26/24.
//

import SwiftUI

struct TrackerView: View {
    @State var selectedDate = Date()
    
    @ObservedObject var trackerVM = TrackerViewModel()

    
    //@State var habitTypes = ["meatlessMeals", "milesDriven"] //, "bottlesUsed"]
    
    var body: some View{
        NavigationStack {
            ZStack{
                VStack{
                    Text("Sustainability Tracker")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .bold()
                        .padding()
                    
                    //replace with weekly calendar view and monthly view at top
                    DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .tint(Color("DarkGreen"))
                        .padding(.horizontal)
                        .onChange(of: selectedDate){
                            newVal in
                            
                                self.trackerVM.fetchHabitData(date: selectedDate.formatted(date: .numeric, time: .omitted))
    //                        for habitType in habitTypes{
    //                            self.trackerVM.fetchData(date: selectedDate.formatted(date: .numeric, time: .omitted), habitType: habitType)
    //                        }
    //                        self.trackerVM.fetchData(date: selectedDate.formatted(date: .numeric, time: .omitted))
                        }
                    
                    //replace with dynamic graphic
                    Image("ScoreGraphicPlaceholder")
                        .resizable()
                        .frame(width:350,height: 200)
                        .padding()
                    
                    HStack {
                        Text("My Sustainable Habits")
                            .font(.title3)
                            .bold()
                            .padding()
                        
                        NavigationLink{
                            DummyLogView(date: selectedDate.formatted(date: .complete, time: .omitted))
                        }
                    label: {
                        Image(systemName:"plus")
                            .resizable()
                            .frame(width:25, height: 25)
                    }
                    .font(.headline)
                    .bold()
                    .foregroundColor(Color("DarkGreen"))
                    .tint(Color("DarkGreen"))
                    }
                    
                    ScrollView {
                        
                        
                        //ForEach habit (loop through array with all habits)
                        //displays habit tracker data
                        ForEach( trackerVM.habits) { habit in
                            //currUsesr
                            if (habit.id == "sophia.k.fayer@vanderbilt.edu"){
                                Text("Meatless Meals: " + habit.meatlessMeals)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(Color("DarkGreen"))
                                    .frame(width: 300, height: 50)
                                    .background(Color("LightGreen"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)
                                Text("Miles Driven: " + habit.milesDriven)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(Color("DarkGreen"))
                                    .frame(width: 300, height: 50)
                                    .background(Color("LightGreen"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)
                                Text("Plastic Waterbottles: " + habit.plasticBottles)
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(Color("DarkGreen"))
                                    .frame(width: 300, height: 50)
                                    .background(Color("LightGreen"))
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)
                            }
                            
                                
                            }
                        }
                    }
                    
                }
                .onAppear(){
                    
    //                for habitType in habitTypes{
    //                    self.trackerVM.fetchHabitData( date: selectedDate.formatted(date: .numeric, time: .omitted))
    //                }
                    self.trackerVM.fetchHabitData( date: selectedDate.formatted(date: .numeric, time: .omitted))
            }
        }
//            .onChange(of: selectedDate){
//                    self.trackerVM.fetchData( date: selectedDate.formatted(date: .numeric, time: .omitted), habitType: "meatlessMeals")
//
//                
//            }
//            .onChange(of: selectedDate, perform: {self.trackerVM.fetchData(date: selectedDate.formatted(date: .numeric, time: .omitted), habitType: "meatlessMeals")})
        }
}

//include a calendar to see history?
//include a graph to see trends over time?
//fix calculator button sizing and icon (?)

//struct TrackerView: View {
//    
//    //tracks date selected on calendar
//    @State var selectedDate: Date = Date()
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                VStack {
//                    
//                    HStack{
//                        Spacer()
//                        //relocate calculate button
//                        NavigationLink{
//                            CalculatorView()
//                        }
//                    label: {
//                        Image(systemName: "plus.forwardslash.minus")
//                            .font(.headline)
//                            .bold()
//                            .frame(width: 55, height: 40)
//                            .foregroundColor(.white)
//                            .background(.green)
//                            .cornerRadius(30)
//                        
//                    }
//                    .padding(.trailing,50)
//
//                    }
//                    
//                    Text("Sustainability Tracker")
//                        .multilineTextAlignment(.leading)
//                        .font(.title2)
//                        .bold()
//                        .padding()
//                    
//                                        
//                    ScrollView{
//                        //Displays calendar
//                        DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
//                            .datePickerStyle(.graphical)
//                            .tint(.green)
//                            .padding(.horizontal)
//                        
//                    }
//                    
//                }
//                
//                
//            }
//        }
//    }
//}
//
////fix rounding of variables with slider
//struct CalculatorView: View{
//    @State var mealsWithMeat = 0.0
//    @State var mealsWithPoultry = 0.0
//    @State var plasticBottles = 0.0
//    @State var milesDriven = 0.0
//    @State var totalEmissions = 0.0
//    
//    @State private var isEditingMeat = false
//    @State private var isEditingPoultry = false
//    @State private var isEditingBottles = false
//    @State private var isEditingMiles = false
//    
//    var body: some View {
//        
//        
//        ZStack {
//            VStack {
//                Text("My Emissions Calculator")
//                    .multilineTextAlignment(.leading)
//                    .font(.title2)
//                    .bold()
//                
//                Text("On average, each day I...")
//                    .bold()
//                    .padding()
//                HStack {
//                    Text("Have \(mealsWithMeat) Meals with Meat")
//                        .frame(width:150)
//                        .multilineTextAlignment(.center)
//                    
//                    VStack {
//                        Slider(
//                            value: $mealsWithMeat,
//                            in: 0...3,
//                            step: 1
//                        ) {
//                            Text("Meals with Meath")
//                        } minimumValueLabel: {
//                            Text("0")
//                        } maximumValueLabel: {
//                            Text("3")
//                        } onEditingChanged: { editing in
//                            isEditingMeat = editing
//                        }
////                        Text("\(mealsWithMeat)")
////                            .foregroundColor(isEditingMeat ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                HStack {
//                    Text("Have \(mealsWithPoultry) Meals with Poultry")
//                        .frame(width:150)
//                        .multilineTextAlignment(.center)
//                    
//                    VStack {
//                        Slider(
//                            value: $mealsWithPoultry,
//                            in: 0...3,
//                            step: 1
//                        ) {
//                            Text("Meals with Poultry")
//                        } minimumValueLabel: {
//                            Text("0")
//                        } maximumValueLabel: {
//                            Text("3")
//                        } onEditingChanged: { editing in
//                            isEditingPoultry = editing
//                        }
////                        Text("\(mealsWithPoultry)")
////                            .foregroundColor(isEditingPoultry ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                
//                HStack {
//                    Text("Use \(round(plasticBottles)) Plastic Waterbottles")
//                        .multilineTextAlignment(.center)
//                        .frame(width:150)
//                    
//                    VStack {
//                        Slider(
//                            value: $plasticBottles,
//                            in: 0...3,
//                            step: 1
//                        ) {
//                            Text("Plastic Bottles")
//                        } minimumValueLabel: {
//                            Text("0")
//                        } maximumValueLabel: {
//                            Text("3")
//                        } onEditingChanged: { editing in
//                            isEditingBottles = editing
//                        }
////                        Text("\(plasticBottles)")
////                            .foregroundColor(isEditingBottles ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                HStack {
//                    Text("Drive \(milesDriven.rounded(.toNearestOrEven)) Miles")
//                        .multilineTextAlignment(.center)
//                        .frame(width:150)
//                    
//                    VStack {
//                        Slider(
//                            value: $milesDriven,
//                            in: 0...30,
//                            step: 1
//                        ) {
//                            Text("Miles Driven")
//                        } minimumValueLabel: {
//                            Text("0")
//                        } maximumValueLabel: {
//                            Text("30")
//                        } onEditingChanged: { editing in
//                            isEditingMiles = editing
//                        }
////                        Text("\(plasticBottles)")
////                            .foregroundColor(isEditingBottles ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                
////                //button here that calls calculate function
////                    calculateEmissions(meat: mealsWithMeat, poultry: mealsWithPoultry, bottles: plasticBottles, miles: milesDriven, total: totalEmissions)
////                    Text("My weekly emissions are  \(String(totalEmissions * 7)).")
////                    Text("My yearly emissions are \(String(totalEmissions * 365))")
////                        
////                }
//            }
//        }
//        
////    func calculateEmissions(meat: Double, poultry: Double, bottles: Double, miles: Double, total: Double){
////        
////        //beef = 60 kg per 1 kg beef -> 6.0 kg per 100 g
////        //chicken = 1.82 kg per 100 g
////        //bottles = .828 kg
////        //mile = .411 kg
////        
////        total += meat * 6.0
////        total += poultry * 1.82
////        total += bottles * .828
////        total += miles * .411
//    }
//    
//}


struct DummyLogView: View {
    
    @ObservedObject var trackerVM = TrackerViewModel()
    
    @State var date = ""
    @State var meatlessMeals = 0.0
    //add other habits here
    
    
    var body: some View {
        ScrollView {
            VStack {
                Text(date)
                    .font(.title2)
                    .bold()
                    .padding()
                Text("Track today's habits")
                    .font(.title3)
                    .bold()
                    .padding()
                Text("Today I...")
                    .padding()
                
                HStack {
                    Text("Had \(String(round(meatlessMeals).rounded(.toNearestOrEven))) Meals without Meat")
                        .frame(width:150)
                        .multilineTextAlignment(.center)
                    
                    VStack {
                        Slider(
                            value: $meatlessMeals,
                            in: 0...3,
                            step: 1
                        ) {
                            Text("Meals without Meat")
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("3")
                            //                    } onEditingChanged: { editing in
                            //                        isEditingMeat = editing
                            //                    }
                            //                        Text("\(mealsWithMeat)")
                            //                            .foregroundColor(isEditingMeat ? .gray : .green)
                        }
                        .frame(width: 200)
                    }
                }
                .padding()
            }
        }
    }

}


#Preview {
    TrackerView()
}
