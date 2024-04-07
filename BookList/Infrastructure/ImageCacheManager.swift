//
//  ImageCacheManager.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let imageCache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    func getImage(for urlString: String) -> UIImage? {
        let key = NSString(string: urlString)
        return imageCache.object(forKey: key)
    }
    
    func storeImage(_ image: UIImage, for urlString: String) {
        let key = NSString(string: urlString)
        imageCache.setObject(image, forKey: key)
    }
}
