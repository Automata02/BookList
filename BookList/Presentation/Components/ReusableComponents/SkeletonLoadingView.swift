//
//  ShimmerView.swift
//  BookList
//
//  Created by automata on 06/04/2024.
//

import SwiftUI

struct SkeletonLoadingView: View {
    @State private var isAnimating = false
    private let animation = Animation.linear(duration: 1).repeatForever(autoreverses: false)
    private var linearGradient: LinearGradient {
        LinearGradient(colors: [
            Colors.skeletonWhite2, Colors.skeletonWhite, Colors.skeletonWhite2
        ], startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        Colors.skeletonBlack
            .frame(width: Size.primarySize.width, height: Size.primarySize.height)
            .overlay(shimmerLayer())
            .onAppear {
                withAnimation(animation) {
                    isAnimating.toggle()
                }
            }
    }
    
    private func shimmerLayer() -> some View {
        return Rectangle()
            .fill(linearGradient)
            .frame(width: Size.secondarySize.width,
                   height: Size.secondarySize.height)
            .rotationEffect(Size.rotationAngle)
            .offset(x: isAnimating ? Size.offset : -Size.offset)
    }
}
