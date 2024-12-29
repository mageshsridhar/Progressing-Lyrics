//
//  LyricLine.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct LyricLine: View {
    @State var lineNumber: Int = 0
    var i: Int
    @State var phase: CGFloat = 0
    @State var textWidth : CGFloat = 0
    @State var startShakeEffect = false
    @Binding var formattedProgress : String
    @Binding var songProgress : CGFloat
    @State var offset : CGFloat = 0
    var body: some View {
        Text(lyricsList[i])
            .font(getFontType(i: i))
            .padding(.vertical, lyricsList[i].count == 5 ? 20 : 0)
            .bold()
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            .modifier(i == lineNumber ? AnimatedMask(phase: phase, textWidth: textWidth, lineNumber: lineNumber) : AnimatedMask(textWidth: 0, lineNumber: i))
            .blur(radius: i == lineNumber ? 0 : 4)
            .glow(color: i == lineNumber && (lineNumber == 7 || lineNumber == 10) ? .purple : .clear, radius: phase * 8)
            .modifier(startShakeEffect ? ShakeEffect(shakeNumber: 16) : ShakeEffect(shakeNumber: 0))
            .background(GeometryReader { g in
                if i == lineNumber {
                    Color.clear.onAppear {
                        textWidth = g.size.width
                        if lineNumber == 18  || lineNumber == 31 {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.linear(duration: animationLength[lineNumber])) {
                                    startShakeEffect = true
                                }
                            }
                        } else {
                            startShakeEffect = false
                        }
                    }
                }
            })
            .offset(y: offset)
            .onChange(of: formattedProgress) { newValue in
                if let scrollToLine = timestamps[newValue] {
                    withAnimation(.spring()) {
                        lineNumber = scrollToLine + 1
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i-lineNumber)) {
                        withAnimation(.spring()) {
                            offset = offset - (33.6 * CGFloat(numberOfLines[scrollToLine])) - 20
                        }
                    }
                    phase = 0
                    withAnimation(.easeInOut(duration: animationLength[lineNumber])) {
                        phase = 1
                    }
                }
            }
            .onChange(of: songProgress) { newValue in
                if newValue > 0 && newValue < 0.0003 {
                    if let scrollToLine = timestamps["00:00"] {
                        withAnimation(.spring()) {
                            lineNumber = scrollToLine + 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(i-lineNumber)) {
                            withAnimation(.spring()) {
                                offset = offset - 15
                            }
                        }
                        phase = 0
                        withAnimation(.easeInOut(duration: animationLength[lineNumber])) {
                            phase = 1
                        }
                    }
                }
            }
    }
}
