//
//  ContentView.swift
//  Progressing Lyrics
//
//  Created by Magesh Sridhar on 12/28/24.
//

import SwiftUI
import AVKit

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer?
    @State private var progress: CGFloat = 0.0
    @State private var playing: Bool = false
    @State private var formattedDuration: String = ""
    @State private var formattedProgress: String = "00:00"

    private static let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        return formatter
    }()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image("Cover")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
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
            }
            .padding(.horizontal, 32)
            .padding(.top, 70)

            LyricView(formattedProgress: $formattedProgress, songProgress: $progress)
                .padding(.top, 30)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 6)
                        .foregroundStyle(.secondary)
                        .opacity(0.3)
                    Rectangle()
                        .frame(width: min(progress * geometry.size.width, geometry.size.width), height: 6)
                        .foregroundStyle(.primary)
                }
                .clipShape(Capsule())
            }
            .frame(height: 6)
            .padding(.horizontal, 32)

            HStack {
                Text(formattedProgress)
                Spacer()
                Text(formattedDuration)
            }
            .font(.caption.monospacedDigit())
            .foregroundStyle(.secondary)
            .padding(.vertical, 10)
            .padding(.horizontal, 30)

            HStack(alignment: .center, spacing: 20) {
                Spacer()
                Image(systemName: "backward.fill")
                    .font(.largeTitle)
                    .imageScale(.small)
                Spacer()
                Button(action: togglePlayback) {
                    Image(systemName: playing ? "pause.fill" : "play.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                }
                .disabled(audioPlayer == nil)
                Spacer()
                Image(systemName: "forward.fill")
                    .font(.largeTitle)
                    .imageScale(.small)
                Spacer()
            }
            .frame(maxWidth: 100)

            Text("Developed by Magesh Sridhar using SwiftUI 💜")
                .font(.caption)
                .bold()
                .padding()
                .padding(.vertical, 10)
        }
        .frame(maxHeight: .infinity)
        .background(
            Image("BG")
                .resizable()
                .scaledToFill()
                .blur(radius: 80)
        )
        .ignoresSafeArea()
        .task {
            loadAudioPlayerIfNeeded()
            // Poll playback ten times a second; cancelled automatically when the view goes away.
            while !Task.isCancelled {
                updateProgress()
                try? await Task.sleep(for: .milliseconds(100))
            }
        }
    }

    private func togglePlayback() {
        guard let audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playing = false
        } else {
            audioPlayer.play()
            playing = true
        }
    }

    private func loadAudioPlayerIfNeeded() {
        guard audioPlayer == nil else { return }
        guard let url = Bundle.main.url(forResource: "Dreaming", withExtension: "mp3"),
              let player = try? AVAudioPlayer(contentsOf: url) else {
            print("Could not load Dreaming.mp3 from the app bundle")
            return
        }
        player.prepareToPlay()
        audioPlayer = player
        formattedDuration = Self.format(player.duration)
    }

    private func updateProgress() {
        guard let audioPlayer, audioPlayer.duration > 0 else { return }
        if !audioPlayer.isPlaying {
            playing = false
        }
        progress = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
        formattedProgress = Self.format(audioPlayer.currentTime)
    }

    private static func format(_ time: TimeInterval) -> String {
        timeFormatter.string(from: time) ?? "00:00"
    }
}

#Preview {
    ContentView()
}
