//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Weerawut Chaiyasomboon on 25/12/2567 BE.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
