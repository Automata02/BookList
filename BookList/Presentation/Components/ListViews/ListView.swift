//
//  ListView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    let list: BookList
    
    var body: some View {
        VStack {
            HStack {
                Text(list.title)
                    .font(.headline)
                Spacer()
                NavigationLink {
                    ExpandedListView(viewModel: viewModel, list: list)
                } label: {
                    Text(Strings.all)
                        .padding(Size.padding)
                        .padding(.horizontal, Size.padding)
                        .background(Colors.buttonBackground)
                        .foregroundStyle(Colors.buttonForeground)
                        .cornerRadius(Size.cornerRadius)
                }
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    if let books = viewModel.books {
                        let filteredBooks = books.filter { $0.listID == list.id }
                        ForEach(filteredBooks.prefix(5)) { book in
                            NavigationLink {
                                BookDetailsView(viewModel: viewModel, book: book)
                            } label: {
                                VerticalListItem(title: book.title, imageURL: book.img)
                            }
                        }
                        if filteredBooks.count > 5 {
                            Text("\(filteredBooks.count - 5) more book\(filteredBooks.count - 5 == 1 ? "" : "s").")
                        }
                    }
                }
            }
        }
        .padding(Size.padding)
        .background(Colors.listBackground.cornerRadius(Size.cornerRadius)
        )
    }
}
