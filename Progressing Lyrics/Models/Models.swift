//
//  Models.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct Lyric {
    enum Effect {
        case none
        /// Purple glow that grows as the line is sung.
        case glow
        /// Horizontal shake while the line is active.
        case shake
    }

    /// Playback time ("mm:ss") at which this line becomes active.
    let start: String?
    let text: String
    /// Number of wrapped lines the text takes on screen. Drives the scroll offset and highlight overlay.
    let lineCount: Int
    /// Seconds the highlight takes to sweep across the line.
    let duration: Double
    var effect: Effect = .none
}

/// The first entry is a blank spacer so the first real line starts below the top fade.
let lyrics: [Lyric] = [
    Lyric(start: nil, text: "", lineCount: 1, duration: 0),
    Lyric(start: "00:00", text: "Freedom of mind, I'm faster than the speed of sound", lineCount: 3, duration: 7),
    Lyric(start: "00:07", text: "Let's dim the lights and shift into new paradise", lineCount: 2, duration: 7),
    Lyric(start: "00:14", text: "Little child, living wild", lineCount: 1, duration: 6),
    Lyric(start: "00:18", text: "Where do you go when you sleep at night?", lineCount: 2, duration: 3),
    Lyric(start: "00:21", text: "Can you reach the sky or walk on fire?", lineCount: 2, duration: 4),
    Lyric(start: "00:25", text: "Where do you go when you're dreaming", lineCount: 2, duration: 5),
    Lyric(start: "00:30", text: "Dreaming?", lineCount: 1, duration: 3, effect: .glow),
    Lyric(start: "00:33", text: "When you're dreaming", lineCount: 1, duration: 5),
    Lyric(start: "00:38", text: "Where do you go when you're dreaming", lineCount: 2, duration: 6),
    Lyric(start: "00:44", text: "Dreaming?", lineCount: 1, duration: 3, effect: .glow),
    Lyric(start: "00:46", text: "When you're dreaming", lineCount: 1, duration: 7),
    Lyric(start: "00:53", text: "Tell me where do you go", lineCount: 1, duration: 1),
    Lyric(start: "00:54", text: "Brwrabum", lineCount: 1, duration: 2),
    Lyric(start: "00:55", text: "Bubipiwrabum", lineCount: 1, duration: 2),
    Lyric(start: "00:56", text: "Brrwraabum Tana tun tun", lineCount: 1, duration: 2),
    Lyric(start: "00:57", text: "Brwrabum", lineCount: 1, duration: 2),
    Lyric(start: "00:58", text: "Bubipiwrabum", lineCount: 1, duration: 2),
    Lyric(start: "00:59", text: "Papapapa", lineCount: 1, duration: 2, effect: .shake),
    Lyric(start: "01:00", text: "Wrrrrooomm", lineCount: 1, duration: 2),
    Lyric(start: "01:01", text: "Brwrabum", lineCount: 1, duration: 2),
    Lyric(start: "01:02", text: "Bubipiwrabum", lineCount: 1, duration: 2),
    Lyric(start: "01:03", text: "Brrwraabum Tun tun tun", lineCount: 1, duration: 2),
    Lyric(start: "01:04", text: "Brwrabum", lineCount: 1, duration: 2),
    Lyric(start: "01:05", text: "Bubipiwrabum", lineCount: 1, duration: 2),
    Lyric(start: "01:06", text: "Bwan bwan bwan wraaw", lineCount: 1, duration: 3),
    Lyric(start: "01:08", text: "Brwyuhum", lineCount: 1, duration: 2),
    Lyric(start: "01:09", text: "Bubipiyuhum", lineCount: 1, duration: 2),
    Lyric(start: "01:10", text: "Brrrwyuhum Tun tun tun", lineCount: 1, duration: 2),
    Lyric(start: "01:11", text: "Brwyuhm", lineCount: 1, duration: 2),
    Lyric(start: "01:12", text: "Bubipiyuhm", lineCount: 1, duration: 2),
    Lyric(start: "01:13", text: "Papapapa", lineCount: 1, duration: 2, effect: .shake),
    Lyric(start: "01:14", text: "Vrrmmmmmmm", lineCount: 1, duration: 2),
    Lyric(start: "01:15", text: "Brwyuhum Bubipiyuhum", lineCount: 1, duration: 2),
    Lyric(start: "01:16", text: "Brwyuhum Bubipiyuhum", lineCount: 1, duration: 2),
    Lyric(start: "01:17", text: "Brrrwyuhum Tun tun tun", lineCount: 1, duration: 2),
    Lyric(start: "01:19", text: "Brwyuhum Bubipiyuhum", lineCount: 1, duration: 2),
    Lyric(start: "01:20", text: "Tell me where do you go", lineCount: 1, duration: 2),
    Lyric(start: "01:27", text: "Tell me where–", lineCount: 1, duration: 1),
    Lyric(start: "01:28", text: "Tell me", lineCount: 1, duration: 1),
    Lyric(start: "01:34", text: "Tell me where do you go", lineCount: 1, duration: 2),
    Lyric(start: "01:41", text: "Tell me where–", lineCount: 1, duration: 1),
    Lyric(start: "01:42", text: "Tell me", lineCount: 1, duration: 1),
    Lyric(start: "01:43", text: "Written by: Christian Valentin Brunn, Danyka Nadeau", lineCount: 2, duration: 3),
]

/// Lyric lines use the title font; the closing credit line is smaller.
func lyricFont(for index: Int) -> Font {
    index < lyrics.count - 1 ? .title : .subheadline
}
