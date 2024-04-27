//
//  SimpleWidget.swift
//  Tranquil WidgetExtension
//
//  Created by Herman Brunborg on 04/01/2024.
//

import WidgetKit
import SwiftUI

struct BlackSquareView: View {
    var body: some View {
        VStack { }
    }
}

struct SimpleProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct BlackSquareWidget: Widget {
    let kind: String = "BlackSquareWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SimpleProvider()) { entry in
            BlackSquareView()
                .containerBackground(.transGrey, for: .widget)
        }
        .supportedFamilies([.systemSmall])
    }
}
#Preview(as: .systemSmall) {
    BlackSquareWidget()
} timeline: {
    SimpleEntry(date: .now)
}
