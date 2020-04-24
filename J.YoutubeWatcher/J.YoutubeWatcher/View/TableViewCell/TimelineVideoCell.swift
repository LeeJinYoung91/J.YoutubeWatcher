//
//  TimelineVideoCell.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 21/02/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class TimelineVideoCell: UITableViewCell {
    @IBOutlet private var videoPlayerView: VideoView?
    @IBOutlet private var channelLabel: UILabel?
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel?
    @IBOutlet private var descriptionLabel: UILabel?
    @IBOutlet weak var detailShowButton: UIButton!
    @IBOutlet var videoTitleToBottomConstraints: NSLayoutConstraint!
    private weak var videoData: YoutubeVideoData?
    
    override func awakeFromNib() {
        initializeUI()
    }
    
    private func initializeUI() {
        videoPlayerView?.layer.masksToBounds = true
        videoPlayerView?.contentMode = .scaleAspectFill
        videoPlayerView?.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 180/255, alpha: 0.5)
        channelLabel?.text = nil
        dateLabel?.text = nil
        descriptionLabel?.text = nil
        videoTitleToBottomConstraints.isActive = true
    }
    
    func setData(_ data:YoutubeVideoData) {
        videoTitleToBottomConstraints.isActive = true
        videoData = data
        videoPlayerView?.image = nil
                                
        videoPlayerView?.af_setImage(withURL: URL(string: data.thumbnailURL)!, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.global(), imageTransition: .noTransition, runImageTransitionIfCached: true, completion: nil)
        
        channelLabel?.text = data.channelTitle
        videoTitleLabel.text = data.videoTitle
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = formatter.date(from: data.publishDate) {
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateLabel?.text = formatter.string(from: date)
        }
        descriptionLabel?.text = data.doc
    }
    
    @IBAction func openDescription(_ sender: Any) {
        videoTitleToBottomConstraints.isActive = !videoTitleToBottomConstraints.isActive
        (superview as? UITableView)?.beginUpdates()
        (superview as? UITableView)?.endUpdates()
    }    
}
