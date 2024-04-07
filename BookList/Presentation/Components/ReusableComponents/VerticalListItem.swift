//
//  ListItem.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct VerticalListItem: View {
    let title: String
    let imageURL: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CachedImageView(urlString: imageURL)
                .applyFrame()
            Text(title)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .padding(.top, Size.padding)
                .foregroundStyle(Colors.textColor)
        }
        .frame(width: Size.listItemWidth, height: Size.listItemHeight)
        .padding()
        .background(Colors.listItemBackground)
        .cornerRadius(Size.cornerRadius)
    }
}
