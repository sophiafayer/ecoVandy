//
//  TipView.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/1/24.
//

import SwiftUI

struct TipView: View {
    var body: some View {
        ZStack{
            Color.green
                .ignoresSafeArea()
            VStack{
                
                Text("Sustainable Tip of the Day!")
                    .font(.title)
                
                
            }
        }
    }
}

#Preview {
    TipView()
}
