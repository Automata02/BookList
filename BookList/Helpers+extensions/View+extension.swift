//
//  View+extension.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

extension View {
    func applyFrame() -> some View {
        self.modifier(thumbnailModifier())
    }
}

private struct thumbnailModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: Size.thumbnailSize, height: Size.thumbnailSize)
            .clipped()
            .cornerRadius(Size.cornerRadius)
    }
}
