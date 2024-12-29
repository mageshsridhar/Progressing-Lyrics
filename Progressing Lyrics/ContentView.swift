//
//  ContentView.swift
//  AppleMusicLyricsPlayer
//
//  Created by Magesh Sridhar on 2/5/23.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State var audioPlayer: AVAudioPlayer!
    @State var progress: CGFloat = 0.0
    @State private var playing: Bool = false
    @State var duration: Double = 0.0
    @State var formattedDuration: String = ""
    @State var formattedProgress: String = "00:00"
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 5)
                VStack(alignment: .leading) {
                    Text("Dreaming (feat. Danyka Nadeau)")
                        .foregroundStyle(.primary)
                        .bold()
                        .font(.subheadline)
                    Text("Virtual Riot")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "ellipsis.circle.fill")
                    .font(.title2)
                    .symbolRenderingMode(.hierarchical)
                
            }.padding(.horizontal).padding(.horizontal).padding(.top, 70)
            LyricView(formattedProgress: $formattedProgress, songProgress: $progress).padding(.top, 30)
            GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle().frame(width: geometry.size.width , height: 6)
                                .foregroundStyle(.secondary)
                                .opacity(0.3)
                            
                            Rectangle().frame(width: min(progress*geometry.size.width, geometry.size.width), height: 6)
                                .foregroundStyle(.primary)
                        }.cornerRadius(45.0)
            }.frame(height: 6)
            .padding(.horizontal)
            .padding(.horizontal)
            HStack {
                Text(formattedProgress)
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
                Spacer()
                Text(formattedDuration)
                    .font(.caption.monospacedDigit())
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            
            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .imageScale(.small)
                Spacer()
                Button(action: {
                    if audioPlayer.isPlaying {
                        playing = false
                        self.audioPlayer.pause()
                    } else if !audioPlayer.isPlaying {
                        playing = true
                        self.audioPlayer.play()
                    }
                }) {
                    Image(systemName: playing ?
                          "pause.fill" : "play.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height:40)
                    .foregroundColor(.white)
                    
                }
                Spacer()
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .imageScale(.small)
                Spacer()
            }.frame(maxWidth: 100)
            
            Text("Developed by Magesh Sridhar using SwiftUI 💜")
                .font(.caption)
                .bold()
                .padding()
                .padding(.vertical, 10)
        }
        .frame(maxHeight: .infinity)
        .background(Image("BG")
            .resizable()
            .scaledToFill()
            .blur(radius: 80))
        .ignoresSafeArea()
        .onAppear {
            initialiseAudioPlayer()
        }
    }
    
    func initialiseAudioPlayer() {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [ .pad ]
        
        let path = Bundle.main.path(forResource: "Dreaming", ofType: "mp3")!
        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        self.audioPlayer.prepareToPlay()
        formattedDuration = formatter.string(from: TimeInterval(self.audioPlayer.duration))!
        duration = self.audioPlayer.duration
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            if !audioPlayer.isPlaying {
                playing = false
            }
            progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
            formattedProgress = formatter.string(from: TimeInterval(self.audioPlayer.currentTime))!
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

extension ContentView {
    func getFontType(i: Int) -> Font {
        return i < lyricsList.count - 1 ? .title : .subheadline
    }
}
