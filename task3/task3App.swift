//
//  task3App.swift
//  task3
//
//  Created by dias on 07.03.2025.
//

import SwiftUI

@main
struct task3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
