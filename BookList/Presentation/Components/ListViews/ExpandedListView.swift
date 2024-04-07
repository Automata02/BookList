//
//  ExpandedListView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct ExpandedListView: View {
    @ObservedObject var viewModel: ViewModel
    let list: BookList
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                if let books = viewModel.books {
                    let filteredBooks = books.filter { $0.listID == list.id }
                    ForEach(filteredBooks) { book in
                        NavigationLink {
                            BookDetailsView(viewModel: viewModel, book: book)
                        } label: {
                            HorizontalListItem(title: book.title,
                                               author: viewModel.bookAuthors?[book.id],
                                               imageURL: book.img,
                                               navigationTitle: list.title
                            )
                        }
                    }
                }
            }
        }
        .refreshable {
            viewModel.leadData()
        }
    }
}
