//
//  TranquilApp.swift
//  Tranquil
//
//  Created by Herman Brunborg on 04/01/2024.
//

import SwiftUI

@main
struct TranquilApp: App {
    func openApp(_ url: URL, notFound: String) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            let webURL = URL(string: notFound)!
            UIApplication.shared.open(webURL)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    UIApplication.shared.open(url)
                }
        }
    }
}
