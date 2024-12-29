//
//  LyricView.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI


struct LyricView: View {
    @Binding var formattedProgress: String
    @Binding var songProgress: CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(0...lyricsList.count - 1, id: \.self) { i in
                LyricLine(i: i, formattedProgress: $formattedProgress, songProgress: $songProgress)
                
            }
        }.padding()
            .padding()
            .offset(y: 1040)
            .frame(height: 450)
            .mask {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .clear, location: .zero),
                        Gradient.Stop(color: .black, location: 0.01),
                        Gradient.Stop(color: .black, location: 0.65),
                        Gradient.Stop(color: .clear, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
    }
}
