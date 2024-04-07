//
//  ContentView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Size.spacing) {
                    if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                    } else if let lists = viewModel.lists {
                        ForEach(lists) { list in
                            ListView(viewModel: viewModel, list: list)
                        }
                    }
                }
                .padding(Size.padding)
                .task {
                    viewModel.leadData()
                }
                .navigationTitle(Strings.mainViewTitle)
                .alert(Strings.errorTitle, isPresented: $viewModel.showAlert) {
                    Button(Strings.primaryActionTitle) { viewModel.leadData() }
                    Button(Strings.secondaryActionTitle, role: .cancel) { }
                } message: {
                    if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                    }
                }
            }
            .refreshable {
                viewModel.leadData()
            }
        }
    }
}
