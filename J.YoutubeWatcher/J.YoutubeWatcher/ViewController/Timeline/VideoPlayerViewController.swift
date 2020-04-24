//
//  VideoPlayerViewController.swift
//  J.YoutubeWatcher
//
//  Created by JinYoung Lee on 12/04/2019.
//  Copyright © 2019 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var videoListTableView: UITableView!
    private var videoData:YoutubeVideoData?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    func setData(_ data: YoutubeVideoData) {
        videoData = data
    }
    
    override func viewDidLoad() {
        videoListTableView.delegate = self
        videoListTableView.dataSource = self
        videoListTableView.rowHeight = 90
    }
}

extension VideoPlayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = Bundle.main.loadNibNamed("VideoDisplayHeader", owner: self, options: nil)?.first as? VideoDisplayHeader
        guard let id = videoData?.ID else {
            return nil
        }
        view?.videoId = id
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 370
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_videoListCell", for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
