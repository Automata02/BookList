//
//  Size.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct Size {
    static let spacing: Double = 10
    static let padding: Double = 10
    static let opacity: Double = 0.1
    
    static let cornerRadius: Double = 5
    static let listItemHeight: Double = 170
    static let listItemWidth: Double = 125
    static let thumbnailSize: CGFloat = 125
    
    static let rotationAngle = Angle(degrees: 70)
    static let primarySize = CGSize(width: 350, height: 200)
    static var secondarySize = CGSize(width: 525, height: 300)
    static var offset: CGFloat {primarySize.width * 1.5 }
}
