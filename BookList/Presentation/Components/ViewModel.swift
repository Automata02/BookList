//
//  MainViewModel.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import Foundation

class ViewModel: ObservableObject {
    var sessionManager: SessionManager
    
    @Published var lists: [BookList]? = nil
    @Published var books: [Book]? = nil
    @Published var bookAuthors: [Int: String]? = nil
    @Published var error: NetworkError? = nil
    @Published var selectedBook: Book? = nil
    @Published var showAlert = false
    
    init(sessionManager: SessionManager) {
        self.sessionManager = sessionManager
    }
    
    func leadData() {
        Task {
            await fetchLists()
            await fetchBooks()
            await fetchBookDetailsAndStoreInBookAuthors()
        }
    }
    
    func fetchLists() async {
        await sessionManager.fetchDecodableData(from: APIEndpoints.lists) { (result: Result<[BookList], Error>) in
            switch result {
            case .success(let lists):
                self.lists = lists
            case .failure(let error):
                self.error = error as? NetworkError
                self.showAlert = true
            }
        }
    }
    
    func fetchBooks() async {
        await sessionManager.fetchDecodableData(from: APIEndpoints.books) { (result: Result<[Book], Error>) in
            switch result {
            case .success(let books):
                self.books = books
            case .failure(let error):
                self.error = error as? NetworkError
                self.showAlert = true
            }
        }
    }
    
    func fetchBookDetails(bookId: Int) async {
        let urlString = APIEndpoints.bookDetails(forBookId: bookId)
        await sessionManager.fetchDecodableData(from: urlString) { (result: Result<Book, Error>) in
            switch result {
            case .success(let bookDetail):
                self.selectedBook = bookDetail
            case .failure(let error):
                self.error = error as? NetworkError
                self.showAlert = true
            }
        }
    }
    
    @MainActor
    func fetchBookDetailsAndStoreInBookAuthors() async {
        guard let books = books else { return }
        
        var bookAuthors = [Int: String]()
        
        for book in books {
            let urlString = APIEndpoints.bookDetails(forBookId: book.id)
            await sessionManager.fetchDecodableData(from: urlString) { (result: Result<Book, Error>) in
                switch result {
                case .success(let bookDetail):
                    bookAuthors[bookDetail.id] = bookDetail.author
                case .failure(let error):
                    self.error = error as? NetworkError
                    self.showAlert = true
                }
            }
        }
        
        DispatchQueue.main.async {
            self.bookAuthors = bookAuthors
        }
    }
}
