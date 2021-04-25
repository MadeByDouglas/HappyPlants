//
//  HappyPlantsApp.swift
//  Shared
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

@main
struct HappyPlantsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
