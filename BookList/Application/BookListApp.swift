//
//  BookListApp.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

@main
struct BookListApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: ViewModel(sessionManager: SessionManager.shared))
        }
    }
}
