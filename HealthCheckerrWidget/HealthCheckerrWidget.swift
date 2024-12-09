import WidgetKit
import SwiftUI

// Simple struct to hold the data for the widget entry
struct SimpleEntry: TimelineEntry {
    let date: Date
    let runningCount: Int
    let exitedCount: Int
}

// The provider for the widget, conforms to the TimelineProvider protocol
struct Provider: TimelineProvider {
    
    // Placeholder function to provide a default entry during widget loading
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), runningCount: 3, exitedCount: 1)
    }

    // Snapshot function to provide a single entry for the widget view
    func snapshot(for configuration: SimpleEntry, in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), runningCount: 5, exitedCount: 2)
    }

    // Timeline function to provide a timeline of entries for the widget
    func timeline(for configuration: SimpleEntry, in context: Context) -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        // Fetch Docker status (you can adjust this based on your actual data)
        let (runningCount, exitedCount) = fetchDockerStatusFromSharedContainer()
        
        // Generate a timeline with Docker status data
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, runningCount: runningCount, exitedCount: exitedCount)
            entries.append(entry)
        }
        
        return Timeline(entries: entries, policy: .atEnd)
    }
    
    // Function to fetch Docker status from shared container
    func fetchDockerStatusFromSharedContainer() -> (Int, Int) {
        if let sharedContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.yourdomain.HealthCheckerr") {
            let defaults = UserDefaults(suiteName: "group.com.yourdomain.HealthCheckerr")
            if let status = defaults?.array(forKey: "dockerStatus") as? [Int], status.count == 2 {
                return (status[0], status[1]) // Running and exited counts
            }
        }
        return (0, 0) // Default value if no data is found
    }
}

// View for the widget entry
struct HealthCheckerrWidgetEntryView: View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text("Running Containers: \(entry.runningCount)")
                .font(.headline)
            Text("Exited Containers: \(entry.exitedCount)")
                .font(.subheadline)
                .foregroundColor(.red)
            Text("Updated at: \(entry.date, style: .time)")
                .font(.footnote)
        }
        .padding()
    }
}

// Widget definition
struct HealthCheckerrWidget: Widget {
    let kind: String = "HealthCheckerrWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HealthCheckerrWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Health Checkerr Widget")
        .description("Shows the Docker instance statuses.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
