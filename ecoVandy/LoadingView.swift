//
//  LoadingView.swift
//  ecoVandy
//
//  Created by Caroline Dunn on 2/27/24.
//

import Foundation
import SwiftUI

struct Loading: View {
    let secondsToDelay = 2.0
    var body: some View {
        ZStack{
            VStack{
                Image("login_logo")
                    .resizable()
                    .scaledToFit()

                Text("Loading...")
                    .font(.title)
                    .padding(.top, 60)
            }
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
    }
}

