//
//  TrackerView.swift
//  ecoVandy
//
//  Created by Sophia Fayer on 2/26/24.
//

//To do
//Load current user
//sliders in log view pull from data from db

import SwiftUI

struct TrackerView: View {
    @State var selectedDate = Date()
    
    
    @ObservedObject var trackerVM = TrackerViewModel()
    @ObservedObject var userVM = UserViewModel()


    
    var body: some View{
        
        let currUserEmail = userVM.user?.email ?? ""
        
        NavigationStack {
            ZStack{
                VStack{
                    Text("Sustainability Tracker")
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color("DarkGreen"))
                        .padding()
                    
                    //replace with weekly calendar view and monthly view at top
                    DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: [.date])
                            .datePickerStyle(.compact)
                            .tint(Color("DarkGreen"))
                            .foregroundStyle(Color("DarkGreen"))
                        .padding(.horizontal)
                        .foregroundStyle(Color("DarkGreen"))
                        .onChange(of: selectedDate){
                            newVal in
                            
                            //add currUser
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
                            .foregroundStyle(Color("DarkGreen"))
                            .padding()
                        
                        NavigationLink{
                            LogView(id: "sophia.k.fayer@vanderbilt.edu", date: selectedDate.formatted(date: .numeric, time: .omitted))
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
                    self.trackerVM.fetchHabitData(date: selectedDate.formatted(date: .numeric, time: .omitted))
    
                        Task{
                                try? await userVM.loadCurrentUser()
                        }
                }
            }
    }
}


struct LogView: View {

    
    @ObservedObject var trackerVM = TrackerViewModel()
    
    @State var id = ""
    @State var date = ""
    @State var meatlessMeals = 0
    @State var milesDriven = 0
    @State var plasticBottles = 0
    //add other habits here
    
    
    var body: some View {
            ZStack {
                
                VStack {
                    Text(date)
                        .font(.title3)
                        .bold()
                        .padding()
                        .foregroundStyle(Color("DarkGreen"))
                    Text("Today I...")
                        .font(.title2)
                        .bold()
                        .padding()
                        .foregroundStyle(Color("DarkGreen"))
                    
                    ScrollView {
                        HStack {
                            Text("Had \(meatlessMeals) Meals without Meat")
                                .frame(width:150)
                                .multilineTextAlignment(.center)
                            
                            VStack {
                                Slider(
                                    value: .convert(from:$meatlessMeals),
                                    in: 0...3,
                                    step: 1
                                ) {
                                    Text("Meals without Meat")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("3")
                                }
                                .padding()
                                .frame(width: 200)
                            }
                        }
                        .padding()
                        .frame(width: 345,height:90)
                        .background(Color("LightGreen"))
                        .foregroundColor(Color("DarkGreen"))
                        .cornerRadius(20) /// make the background rounded
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color("DarkGreen"), lineWidth: 5))
                        
                        HStack {
                            Text("Drove \(milesDriven) miles")
                                .frame(width:150)
                                .multilineTextAlignment(.center)
                            
                            VStack {
                                Slider(
                                    value: .convert(from:$milesDriven),
                                    in: 0...30,
                                    step: 1
                                ) {
                                    Text("Miles Driven")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("30")
                                }
                                .padding()
                                .frame(width: 200)
                            }
                        }
                        .padding()
                        .frame(width: 345,height:90)
                        .background(Color("LightGreen"))
                        .foregroundColor(Color("DarkGreen"))
                        .cornerRadius(20) /// make the background rounded
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color("DarkGreen"), lineWidth: 5))
                        
                        HStack {
                            Text("Used \(plasticBottles) plastic bottles")
                                .frame(width:150)
                                .multilineTextAlignment(.center)
                            
                            VStack {
                                Slider(
                                    value: .convert(from:$plasticBottles),
                                    in: 0...10,
                                    step: 1
                                ) {
                                    Text("Plastic Bottles")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text("10")
                                }.padding()
                                .frame(width: 200)
                            }
                        }
                        .padding()
                        .frame(width: 345,height:90)
                        .background(Color("LightGreen"))
                        .foregroundColor(Color("DarkGreen"))
                        .cornerRadius(20) /// make the background rounded
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color("DarkGreen"), lineWidth: 5))
                    }
                    Button("Save") {
                        trackerVM.updateHabitData(date: date, id: id, meatlessMeals: String(meatlessMeals), milesDriven: String(milesDriven), plasticBottles: String(plasticBottles))
                    }
                    .frame(width:100, height: 30)
                    .background(Color("DarkGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color("DarkGreen"), lineWidth: 5))
//                    .frame(width: 50, height: 20)
//                    .cornerRadius(30)
//                    .background(Color("DarkGreen"))
//                    .foregroundColor(.white)
                }
            }
        }
}

public extension Binding {

    static func convert<TInt, TFloat>(from intBinding: Binding<TInt>) -> Binding<TFloat>
    where TInt:   BinaryInteger,
          TFloat: BinaryFloatingPoint{

        Binding<TFloat> (
            get: { TFloat(intBinding.wrappedValue) },
            set: { intBinding.wrappedValue = TInt($0) }
        )
    }

    static func convert<TFloat, TInt>(from floatBinding: Binding<TFloat>) -> Binding<TInt>
    where TFloat: BinaryFloatingPoint,
          TInt:   BinaryInteger {

        Binding<TInt> (
            get: { TInt(floatBinding.wrappedValue) },
            set: { floatBinding.wrappedValue = TFloat($0) }
        )
    }
}



#Preview {
    TrackerView()
}
