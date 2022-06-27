//
//  ContentView.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TasksView()
                .navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
