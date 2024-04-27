//
//  AppIntent.swift
//  Tranquil Widget
//
//  Created by Herman Brunborg on 04/01/2024.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Widget for Tranquil")
}
