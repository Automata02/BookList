//
//  BookListTests.swift
//  BookListTests
//
//  Created by automata on 06/04/2024.
//

import XCTest
@testable import BookList

final class Tests: XCTestCase {
    func testFetchDecodableDataSuccess() async throws {
        let mockSession = MockURLSession()
        let book = Book(id: 1, listID: 2, isbn: "123456789", publicationDate: nil, author: "Roberts Kursitis", title: "Untitled", img: "image_url", description: "Lorum ipsum")
        mockSession.mockData = try JSONEncoder().encode(book)
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "https://nhk.moe")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionManager = SessionManager(session: mockSession as! URLSessionProtocol)
        
        var fetchedBook: Book?
        
        await sessionManager.fetchDecodableData(from: "https://nhk.moe") { (result: Result<Book, Error>) in
            switch result {
            case .success(let book):
                fetchedBook = book
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        
        XCTAssertNotNil(fetchedBook)
        XCTAssertEqual(fetchedBook?.id, book.id)
        XCTAssertEqual(fetchedBook?.title, book.title)
        XCTAssertEqual(fetchedBook?.author, book.author)
    }
}
