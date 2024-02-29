//
//  TrackerView.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/26/24.
//

import SwiftUI
import HorizonCalendar
import UIKit


//Update Calendar Display
struct TrackerView: View {
    @State var selectedDate = Date()
    
    //change to Caroline's
    @ObservedObject var trackerVM = TrackerViewModel()
    
    var body: some View{
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
                        .tint(.green)
                    .padding(.horizontal)
                
                //replace with dynamic graphic
                Image("ScoreGraphicPlaceholder")
                    .resizable()
                    .frame(width:350,height: 200)
                    .tint(.green)
                
                //Displays calendar
                ScrollView {
                    
                    Text("My Sustainable Habits:")
                        .font(.title3)
                        .bold()
                        .padding()
                    
                    
                    //displays habit tracker data
//                    ForEach( trackerVM.habits) {habit in
//                        Text(habit.habit + ": " + habit.habitVal)
//                            .font(.headline)
//                            .bold()
//                            .foregroundColor(.white)
//                            .frame(width: 300, height: 50)
//                            .background(.green)
//                            .cornerRadius(10)
//                            .padding(.bottom, 10)
//                            
//                        }
                    }
                }
                
            }
//            .onAppear(){
//                self.trackerVM.fetchHabit(id: "ypfTAHk2RRwuccNKRYi3", habit: "meatlessMeals", date: selectedDate.formatted(date: .complete, time: .omitted))
//        
//            }
        }
}

//private func createCalendar(){
//    let calendar = Calendar.current
//    let startDate = calendar.date(from: DateComponents(year:2024, month:1, day: 1))!
//    let endDate = Date()
//    
//    let content = CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
//    
//    let calendarView = CalendarView(initialContent: content)
//    
//    calendarView.translatesAutoresizingMaskIntoConstraints = false
//}
//    NSLayoutConstraint.activate([
//        calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//        calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//        calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//        calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])



#Preview{
    TrackerView()
}

//final class TrackerViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        createCalendar()
//    }
//    
//    private func createCalendar(){
//        let calendar = Calendar.current
//        let startDate = calendar.date(from: DateComponents(year:2024, month:1, day: 1))!
//        let endDate = Date()
//        
//        let content = CalendarViewContent(calendar: calendar, visibleDateRange: startDate...endDate, monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
//        
//        let calendarView = CalendarView(initialContent: content)
//        
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            calendarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
//            calendarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
//            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//            ])
//    }
//}

//struct TrackerView: View{
//    
//    var body: some View {
//        ZStack{
//            VStack {
//                Text("Sustainability Tracker")
//                    .multilineTextAlignment(.leading)
//                    .font(.title2)
//                    .bold()
//                
//                
//                
//                //
//                let calendarView = CalendarView(initialContent: makeContent())
//                
//                body.addSubview(calendarView)
//
//                calendarView.translatesAutoresizingMaskIntoConstraints = false
//
//                NSLayoutConstraint.activate([
//                  calendarView.leadingAnchor.constraint(equalTo: body.layoutMarginsGuide.leadingAnchor),
//                  calendarView.trailingAnchor.constraint(equalTo: body.layoutMarginsGuide.trailingAnchor),
//                  calendarView.topAnchor.constraint(equalTo: body.layoutMarginsGuide.topAnchor),
//                  calendarView.bottomAnchor.constraint(equalTo: body.layoutMarginsGuide.bottomAnchor),
//                ])
//                
//            }
//                
//        }
//    }
//}
//
//private func makeContent() -> CalendarViewContent {
//  let calendar = Calendar.current
//
//  let startDate = calendar.date(from: DateComponents(year: 2020, month: 01, day: 01))!
//  let endDate = calendar.date(from: DateComponents(year: 2021, month: 12, day: 31))!
//    
//
//  return CalendarViewContent(
//    calendar: calendar,
//    visibleDateRange: startDate...endDate,
//    monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
//    
//    
//}
//
//#Preview {
//    TrackerView()
//}

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
//                Text("On average, each day if I...")
//                    .bold()
//                    .padding()
//                HStack {
//                    Text("Have \(String(round(mealsWithMeat))) Less Meals with Meat")
//                        .frame(width:150)
//                        .multilineTextAlignment(.center)
//                    
//                    VStack {
//                        Slider(
//                            value: $mealsWithMeat,
//                            in: 0...3,
//                            step: 1
//                        ) {
//                            Text("Meals with Meat")
//                        } minimumValueLabel: {
//                            Text("0")
//                        } maximumValueLabel: {
//                            Text("3")
//                        } onEditingChanged: { editing in
//                            isEditingMeat = editing
//                        }
//                        //                        Text("\(mealsWithMeat)")
//                        //                            .foregroundColor(isEditingMeat ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                HStack {
//                    Text("Have \(String(round(mealsWithPoultry))) Less Meals with Poultry")
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
//                        //                        Text("\(mealsWithPoultry)")
//                        //                            .foregroundColor(isEditingPoultry ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                
//                HStack {
//                    Text("Use \(String(round(plasticBottles))) Less Plastic Waterbottles")
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
//                        //                        Text("\(plasticBottles)")
//                        //                            .foregroundColor(isEditingBottles ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                HStack {
//                    Text("Drive \(String(round(milesDriven))) Miles Less")
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
//                        //                        Text("\(plasticBottles)")
//                        //                            .foregroundColor(isEditingBottles ? .gray : .green)
//                    }
//                    .frame(width: 200)
//                }
//                
//                //                //button here that calls calculate function
//                //                    calculateEmissions(meat: mealsWithMeat, poultry: mealsWithPoultry, bottles: plasticBottles, miles: milesDriven, total: totalEmissions)
//                //                    Text("My weekly emissions are  \(String(totalEmissions * 7)).")
//                //                    Text("My yearly emissions are \(String(totalEmissions * 365))")
//                //
//                //                }
//                .padding()
//                .onAppear()
//                    Text("My weekly CO2 emissions saved: \(String(round(calculateEmissions(meat: mealsWithMeat, poultry: mealsWithPoultry, bottles: plasticBottles, miles: milesDriven) * 7.0 ))) kg")
//                    .frame(width:350,alignment: .center)
//                    .padding()
//                
//                    Text("My annual CO2 emissions saved: \(String(round(calculateEmissions(meat: mealsWithMeat, poultry: mealsWithPoultry, bottles: plasticBottles, miles: milesDriven) * 365.0 ))) kg")
//                    .frame(width:350,alignment: .center)
//            }
//        }
//    }
//        
//    func calculateEmissions(meat: Double, poultry: Double, bottles: Double, miles: Double) -> Double{
//        
//                //beef = 60 kg per 1 kg beef -> 6.0 kg per 100 g
//                //chicken = 1.82 kg per 100 g
//                //bottles = .828 kg
//                //mile = .411 kg
//        
////                let total = 0.0
////                
////                total += meat * 6.0
////                total += poultry * 1.82
////                total += bottles * 0.828
////                total += miles * 0.411
//                
//                return  meat * 6.0 + poultry * 1.82 + bottles * 0.828 + miles * 0.411
//            }
//        
//    }
//
//
//
//
//#Preview {
//    TrackerView()
//}
