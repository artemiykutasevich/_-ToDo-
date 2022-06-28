//
//  SymbolButton.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 28.06.22.
//

import SwiftUI

struct SymbolButton: View {
    let symbolName: String
    let symbolColor: Color
    let function: (() -> Void)
    
    var body: some View {
        Button(action: {
            function()
        }, label: {
            Image(systemName: symbolName)
                .symbolStyle(color: symbolColor)
        })
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        SymbolButton(
            symbolName: "arrow.left",
            symbolColor: .black,
            function: {
                print("My Custom Button")
            })
    }
}
