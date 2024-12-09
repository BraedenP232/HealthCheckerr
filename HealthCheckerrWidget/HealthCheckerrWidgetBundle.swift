//
//  HealthCheckerrWidgetBundle.swift
//  HealthCheckerrWidget
//
//  Created by Braeden Pelletier on 2024-12-08.
//

import WidgetKit
import SwiftUI

@main
struct HealthCheckerrWidgetBundle: WidgetBundle {
    var body: some Widget {
        HealthCheckerrWidget()
        HealthCheckerrWidgetControl()
        HealthCheckerrWidgetLiveActivity()
    }
}
