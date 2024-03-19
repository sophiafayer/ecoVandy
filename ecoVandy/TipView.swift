//
//  TipView.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/1/24.
//

import SwiftUI


struct TipView: View {
    @ObservedObject var viewModel = TipViewModel()
    
    var body: some View {
        let tip = viewModel.sustainableTip
            VStack{
                Text("Sustainable Tip of the Day")
                    .font(.title)
                    .foregroundStyle(Color("DarkGreen"))
                    .bold()
                    .padding(.bottom, 5)
                    .padding(.top, 20)
                Text(viewModel.date)
                    .font(.title2)
                    .foregroundColor(Color("DarkGreen"))
                    .padding(.bottom, 30)
                ZStack{
                    Rectangle()
                        .frame(width:370, height: 150)
                        .foregroundColor(Color("LightGreen"))
                        .cornerRadius(20)
                    VStack{
                        Image(systemName: viewModel.imageName)
                            .font(.largeTitle)
                            .foregroundColor(Color("DarkGreen"))
                        Text(tip?.tip ?? "")
                            .font(.title3)
                            .frame(width: 330, height: 50)
                            .foregroundColor(Color("DarkGreen"))
                    }
                }
                .padding(.bottom, 30)
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
                Text(tip?.explanation ?? "")
                    .font(.title3)
                    .padding(.top, 5)
                    .frame(width: 300, height: 150)
                    .foregroundColor(Color("DarkGreen"))
                Spacer()
            }
            .onAppear(){
                Task{
                    do{
                        try await viewModel.loadTip()
                        viewModel.getTodaysDate()
                    }
                    catch
                    {
                        print("Error loading tip :\(error.localizedDescription)")
                    }
                }
                
            }
        }
    


}

#Preview {
    TipView()
}
