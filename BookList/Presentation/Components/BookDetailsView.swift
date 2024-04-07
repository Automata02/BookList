//
//  BookDetailsView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct BookDetailsView: View {
    @ObservedObject var viewModel: ViewModel
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    CachedImageView(urlString: book.img)
                        .frame(height: geo.size.height / 3)
                        .clipped()
                    VStack(alignment: .leading, spacing: Size.spacing) {
                        Text(book.title)
                            .font(.title2)
                        if let author = viewModel.selectedBook?.author {
                            Text("By \(author)")
                        }
                        if let isbn = viewModel.selectedBook?.isbn {
                            Text("ISBN: \(isbn)")
                        }
                        if let publicationDate = viewModel.selectedBook?.publicationDate {
                            Text("Published: \(publicationDate.formattedDayMonthYear())")
                        }
                        if let description = viewModel.selectedBook?.description {
                            Text(description)
                        }
                    }
                }
            }
            .padding(Size.padding)
            .task {
                await viewModel.fetchBookDetails(bookId: book.id)
            }
            .refreshable {
                viewModel.leadData()
            }
            .onDisappear {
                viewModel.selectedBook = nil
            }
            .navigationTitle(Strings.bookDetailsTitle)
        }
    }
}
