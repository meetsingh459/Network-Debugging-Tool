import Foundation
import AVFoundation

final class AudioService {
    private var player: AVPlayer?

    func play(for url: String) {
        let audioURLString = url.hasPrefix("//") ? "https:" + url : url
        guard let audioURL = URL(string: audioURLString) else {
            return
        }

        // Initialize the shared player and start playback
        let playerItem = AVPlayerItem(url: audioURL)
        if player == nil {
            player = AVPlayer(playerItem: playerItem)
        } else {
            player?.replaceCurrentItem(with: playerItem)
        }
        
        player?.play()
    }
}
