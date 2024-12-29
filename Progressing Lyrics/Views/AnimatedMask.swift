//
//  AnimatedMask.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct AnimatedMask: AnimatableModifier {
    var phase: CGFloat = 0
    var textWidth: CGFloat
    var lineNumber: Int
    
    var animatableData: CGFloat {
        get { phase }
        set { phase = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(OverlayView(width: textWidth, progress: phase, lineNumber: lineNumber))
            .mask(MaskTextView(lineNumber: lineNumber))
    }
}
