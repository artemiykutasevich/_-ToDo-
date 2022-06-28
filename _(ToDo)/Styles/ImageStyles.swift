//
//  ImageStyles.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 27.06.22.
//

import SwiftUI

struct SymbolsStyleModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(color)
    }
}

extension Image {
    func symbolStyle(color: Color = BackgroundColors.blackColor) -> some View {
        self.modifier(SymbolsStyleModifier(color: color))
    }
}
