//
//  CaloriesApp.swift
//  Calories
//
//  Created by jaewon Lee on 5/7/24.
//

import SwiftUI

@main
struct CaloriesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
