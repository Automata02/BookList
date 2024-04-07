//
//  ImageLoader.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellables = Set<AnyCancellable>()
    
    func loadImage(fromURL urlString: String) {
        if let cachedImage = ImageCacheManager.shared.getImage(for: urlString) {
            self.image = cachedImage
        } else {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] downloadedImage in
                    if let downloadedImage = downloadedImage {
                        ImageCacheManager.shared.storeImage(downloadedImage, for: urlString)
                        self?.image = downloadedImage
                    }
                })
                .store(in: &cancellables)
        }
    }
}
