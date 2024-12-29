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
        Text(lyricsList[lineNumber])
            .font(getFontType(i: lineNumber))
            .padding(.vertical, lyricsList[lineNumber].count == 5 ? 20 : 0)
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
}
