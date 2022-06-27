//
//  TextStyles.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 27.06.22.
//

import SwiftUI

struct TitleStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Fonts.permanentMarker)
    }
}

struct CalloutStyleModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.callout.bold())
            .foregroundColor(color)
    }
}

struct CaptionStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

extension Text {
    func titleStyle() -> some View {
        self.modifier(TitleStyleModifier())
    }
    
    func calloutStyle(color: Color = Color(BackgroundColors.black.rawValue)) -> some View {
        self.modifier(CalloutStyleModifier(color: color))
    }
    
    func captionStyle() -> some View {
        self.modifier(CaptionStyleModifier())
    }
}
