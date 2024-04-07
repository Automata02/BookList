//
//  HorizontalListItem.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct HorizontalListItem: View {
    let title: String
    let author: String?
    let imageURL: String
    let navigationTitle: String
    
    var body: some View {
        HStack {
            CachedImageView(urlString: imageURL)
                .applyFrame()
                .padding(Size.padding)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(Colors.textColor)
                Text(author ?? Strings.unknownAuthor)
                    .foregroundStyle(Colors.textColor)
            }
            Spacer()
        }
        .background(Colors.listBackground.cornerRadius(Size.cornerRadius))
        .padding(Size.padding)
        .navigationTitle(navigationTitle)
    }
}
