//
//  VideoView.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class VideoView: UIImageView {
    private weak var avPlayer: AVPlayer?
    private var avPlayerlayer = AVPlayerLayer()
    func didChangeValue<Value>(for keyPath: KeyPath<VideoView, Value>) {
        
    }
    
    func setVideoData(_ data:YoutubeVideoData) {
        
    }
}
