//
//  Tranquil_Widget.swift
//  Tranquil Widget
//
//  Created by Herman Brunborg on 04/01/2024.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        entries.append(SimpleEntry(date: Date()))
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct Tranquil_WidgetEntryView : View {
    var entry: Provider.Entry
    var links: [String] = UserDefaults(suiteName: "group.com.knia.tranquil")!.stringArray(forKey: "SavedLinks") ?? ["not able to find apps"]

    var body: some View {
        VStack {
            ForEach(links, id: \.self) { link in
                Link(destination: URL(string: "shortcuts://run-shortcut?name=TranquilOpenApp&input=\(link)")!) {
                    Text(link)
                        .bold()
                        .padding()
                        .foregroundColor(.folderGrey)
                }
            }
        }
    }
}

struct Tranquil_Widget: Widget {
    let kind: String = "Tranquil_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Tranquil_WidgetEntryView(entry: entry)
                .containerBackground(.transGrey, for: .widget)
        }
        .supportedFamilies([.systemLarge])
    }
}

#Preview(as: .systemLarge) {
    Tranquil_Widget()
} timeline: {
    SimpleEntry(date: .now)
}
