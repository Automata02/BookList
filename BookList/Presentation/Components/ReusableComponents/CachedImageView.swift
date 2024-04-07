//
//  CachedImageView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct CachedImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(urlString: String) {
        _imageLoader = ObservedObject(wrappedValue: ImageLoader())
        imageLoader.loadImage(fromURL: urlString)
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } else {
                SkeletonLoadingView()
            }
        }
    }
}
