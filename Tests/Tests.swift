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
        mockSession.mockData = try JSONEncoder().encode(MockBook.book)
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "https://nhk.moe")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let sessionManager = SessionManager(session: mockSession)
        
        await sessionManager.fetchDecodableData(from: "https://nhk.moe") { (result: Result<Book, Error>) in
            switch result {
            case .success(let result):
                XCTAssertNotNil(result)
                XCTAssertEqual(result.id, MockBook.book.id)
                XCTAssertEqual(result.title, MockBook.book.title)
                XCTAssertEqual(result.author, MockBook.book.author)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func testNetworkErrorNotFound() async throws {
        let mockSession = MockURLSession()
        mockSession.mockData = try JSONEncoder().encode(MockBook.book)
        mockSession.mockResponse = HTTPURLResponse(url: URL(string: "https://nhk.moe")!, statusCode: 404, httpVersion: nil, headerFields: nil)
        
        let sessionManager = SessionManager(session: mockSession)
        
        await sessionManager.fetchDecodableData(from: "https://nhk.moe") { (result: Result<Book, Error>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, "A network error occurred: Network request failed with status code 404.")
            default:
                XCTFail("No error")
            }
        }
    }
}
