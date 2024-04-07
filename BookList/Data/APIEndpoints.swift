//
//  APIEndpoints.swift
//  BookList
//
//  Created by automata on 07/04/2024.
//

import Foundation

struct APIEndpoints {
    static let baseURL = "https://my-json-server.typicode.com/KeskoSenukaiDigital/assignment"
    
    static var lists: String {
        return "\(baseURL)/lists"
    }
    
    static var books: String {
        return "\(baseURL)/books"
    }
    
    static func bookDetails(forBookId bookId: Int) -> String {
        return "\(baseURL)/book/\(bookId)"
    }
}
