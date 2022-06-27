//
//  CardColors.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI

enum CardColors: String, CaseIterable {
    case blue = "Blue"
    case green = "Green"
    case red = "Red"
    case yellow = "Yellow"
    
    static func getCardColor(from string: String) -> CardColors {
        for color in CardColors.allCases {
            if color.rawValue == string {
                return color
            }
        }
        return .blue
    }
}
