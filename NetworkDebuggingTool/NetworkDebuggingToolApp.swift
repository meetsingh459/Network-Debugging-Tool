//
//  NetworkDebuggingToolApp.swift
//  NetworkDebuggingTool
//
//  Created by Manmeet on 14/09/26.
//

import SwiftUI

@main
struct NetworkDebuggingToolApp: App {
    var body: some Scene {
        WindowGroup {
            DictionaryView()
                .task {
                    NetworkDebugger.shared.start()
                }
        }
    }
}
