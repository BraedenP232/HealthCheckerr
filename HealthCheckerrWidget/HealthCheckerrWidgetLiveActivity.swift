//
//  HealthCheckerrWidgetLiveActivity.swift
//  HealthCheckerrWidget
//
//  Created by Braeden Pelletier on 2024-12-08.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct HealthCheckerrWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct HealthCheckerrWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: HealthCheckerrWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension HealthCheckerrWidgetAttributes {
    fileprivate static var preview: HealthCheckerrWidgetAttributes {
        HealthCheckerrWidgetAttributes(name: "World")
    }
}

extension HealthCheckerrWidgetAttributes.ContentState {
    fileprivate static var smiley: HealthCheckerrWidgetAttributes.ContentState {
        HealthCheckerrWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: HealthCheckerrWidgetAttributes.ContentState {
         HealthCheckerrWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: HealthCheckerrWidgetAttributes.preview) {
   HealthCheckerrWidgetLiveActivity()
} contentStates: {
    HealthCheckerrWidgetAttributes.ContentState.smiley
    HealthCheckerrWidgetAttributes.ContentState.starEyes
}
