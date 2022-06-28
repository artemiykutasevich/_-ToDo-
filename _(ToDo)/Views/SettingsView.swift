//
//  SettingsView.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 28.06.22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: TasksViewModel
    @Environment(\.self) var enviroment
    
    var body: some View {
        VStack {
            Text("Settings")
                .titleStyle()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    SymbolButton(
                        symbolName: "arrow.left",
                        symbolColor: BackgroundColors.blackColor,
                        function: {
                            enviroment.dismiss()
                        })
                }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(TasksViewModel())
    }
}
