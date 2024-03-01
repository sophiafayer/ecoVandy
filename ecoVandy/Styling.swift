//
//  Styling.swift
//  ecoVandy
//
//  Created by Sydney Leonardi on 3/1/24.
//

import Foundation
import SwiftUI

let tipBackgroundGradient = LinearGradient(
    gradient: Gradient(stops: [
        .init(color: Color(.green), location: 0),
        .init(color: Color(.white), location: 1)]),
    startPoint: UnitPoint(x: 0.5, y: 0),
    endPoint: UnitPoint(x: 0.5, y: 1))
