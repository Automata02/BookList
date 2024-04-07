//
//  Book.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import UIKit

struct Book: Codable, Identifiable {
    let id, listID: Int
    let isbn: String?
    let publicationDate: Date?
    let author: String?
    let title: String
    let img: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case listID = "list_id"
        case isbn
        case publicationDate = "publication_date"
        case author, title, img, description
    }
    
    var image: UIImage? {
        return ImageCacheManager.shared.getImage(for: img)
    }
}
