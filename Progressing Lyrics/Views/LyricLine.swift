//
//  LyricLine.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct LyricLine: View {
    /// Height of one wrapped line of title text, used to scroll the list up.
    private static let wrappedLineHeight: CGFloat = 33.6
    /// Matches the VStack spacing in LyricView.
    private static let lineSpacing: CGFloat = 20
    /// Small nudge applied when playback first starts.
    private static let initialScroll: CGFloat = 15

    let index: Int
    @Binding var formattedProgress: String
    @Binding var songProgress: CGFloat

    @State private var lineNumber: Int = 0
    @State private var phase: CGFloat = 0
    @State private var textWidth: CGFloat = 0
    @State private var startShakeEffect = false
    @State private var offset: CGFloat = 0

    private var lyric: Lyric { lyrics[index] }
    private var isActive: Bool { index == lineNumber }

    var body: some View {
        Text(lyric.text)
            .font(lyricFont(for: index))
            .bold()
            .foregroundStyle(.secondary)
            .fixedSize(horizontal: false, vertical: true)
            .modifier(isActive ? AnimatedMask(phase: phase, textWidth: textWidth, lineNumber: lineNumber) : AnimatedMask(textWidth: 0, lineNumber: index))
            .blur(radius: isActive ? 0 : 4)
            .glow(color: isActive && lyric.effect == .glow ? .purple : .clear, radius: phase * 8)
            .modifier(ShakeEffect(shakeNumber: startShakeEffect ? 16 : 0))
            .background(GeometryReader { g in
                if isActive {
                    Color.clear.onAppear {
                        textWidth = g.size.width
                        if lyric.effect == .shake {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                withAnimation(.linear(duration: lyric.duration)) {
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
            .onChange(of: formattedProgress) { _, newValue in
                guard let newLine = lyrics.firstIndex(where: { $0.start == newValue }) else { return }
                let previousLine = lyrics[newLine - 1]
                activate(line: newLine, scrollBy: Self.wrappedLineHeight * CGFloat(previousLine.lineCount) + Self.lineSpacing)
            }
            .onChange(of: songProgress) { oldValue, newValue in
                // formattedProgress starts at "00:00", so its onChange never fires for the first line.
                // Activate it the moment playback first moves off zero instead.
                if oldValue == 0 && newValue > 0 {
                    activate(line: 1, scrollBy: Self.initialScroll)
                }
            }
    }

    /// Makes `newLine` the active line, scrolls this row up, and restarts the highlight sweep.
    private func activate(line newLine: Int, scrollBy distance: CGFloat) {
        withAnimation(.spring()) {
            lineNumber = newLine
        }
        // Rows below the active one start moving slightly later, giving a cascading scroll.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index - newLine)) {
            withAnimation(.spring()) {
                offset -= distance
            }
        }
        phase = 0
        withAnimation(.easeInOut(duration: lyrics[newLine].duration)) {
            phase = 1
        }
    }
}

extension View {
    func glow(color: Color = .red, radius: CGFloat = 20) -> some View {
        self
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
            .shadow(color: color, radius: radius / 3)
    }
}
