//
//  DevoteApp.swift
//  Devote
//
//  Created by Богдан Беннер on 25.09.22.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared
	@AppStorage("isDarkMode") var isDarkMode = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
				.preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
