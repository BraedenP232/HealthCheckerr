//
//  HealthCheckerrApp.swift
//  HealthCheckerr
//
//  Created by Braeden Pelletier on 2024-12-07.
//

import SwiftUI

@main
struct HealthCheckerrApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DockerInstancesView()
        }
    }
}
