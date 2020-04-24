//
//  VideoDisplayHeader.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 12/04/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class VideoDisplayHeader: UIView {
    @IBOutlet weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var channelTitleLabel: UILabel!
    private var playlistID: String?
    var videoId: String {
        get {
            return playlistID!
        }
        set {
            youtubePlayer.load(withVideoId: newValue)
        }
    }
    
    override func awakeFromNib() {
        youtubePlayer.delegate = self
    }
}

extension VideoDisplayHeader: YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .buffering:
            print("buffer")
            break
        case .queued:
            print("queue")
            break
        case .unstarted:
            print("unstarted")
            break
        case .ended:
            print("ended")
            break
        case .playing:
            print("playing")
            break
        case .paused:
            print("pause")
            break
        case .unknown:
            print("unknown")
            break
        @unknown default:
            break
        }
    }
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        let loadingView = UIView(frame: youtubePlayer.frame)
        loadingView.backgroundColor = UIColor.black
        return loadingView
    }
}
