//
//  __ToDo_App.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI

@main
struct __ToDo_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
