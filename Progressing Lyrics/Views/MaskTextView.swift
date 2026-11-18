//
//  MaskTextView.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI

struct MaskTextView : View {
    var lineNumber: Int
    var body: some View {
        Text(lyrics[lineNumber].text)
            .font(lyricFont(for: lineNumber))
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
}
