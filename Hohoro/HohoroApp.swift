//
//  HohoroApp.swift
//  Hohoro
//
//  Created by warit karn on 9/2/2568 BE.
//

import SwiftUI

@main
struct HohoroApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
