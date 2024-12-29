//
//  OverlayView.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct OverlayView: View {
    let width: CGFloat
    let progress: CGFloat
    let lineNumber: Int
    var body: some View {
        Path() { path in
            for i in 0...numberOfLines[lineNumber] {
                let yValue : CGFloat = (18 * CGFloat(i+1)) + (20 * CGFloat(i))
                path.move(to: CGPoint(x: 0, y: yValue))
                path.addLine(to: CGPoint(x: width, y: yValue))
            }
        }.trim(from: 0, to: progress)
            .stroke(lineWidth: 38)
    }
}
